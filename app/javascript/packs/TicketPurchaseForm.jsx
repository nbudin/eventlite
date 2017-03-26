import React, { PropTypes } from 'react';
import PaymentEntry from './PaymentEntry';
import { enableUniqueIds } from 'react-html-id';
import getCSRFToken from './getCSRFToken';

class TicketPurchaseForm extends React.Component {
  static propTypes = {
    ticketTypes: PropTypes.arrayOf(
      PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        price: PropTypes.number.isRequired,
        formattedPrice: PropTypes.string.isRequired,
        available: PropTypes.bool.isRequired
      })
    ).isRequired,
    createChargeUrl: PropTypes.string.isRequired,
    purchaseCompleteUrl: PropTypes.string.isRequired
  };

  constructor(props) {
    super(props);

    this.state = {
      paymentError: null,
      submitting: false,
      stripeToken: null,
      ticketTypeId: "",
      ccNumber: "",
      cvc: "",
      expMonth: "",
      expYear: "",
      zip: "",
      name: "",
      email: "",
      phone: "",
    };

    enableUniqueIds(this);
  }

  fieldChanged = (attribute, e) => {
    this.setState({ [attribute]: e.target.value });
  }

  submitPayment = (e) => {
    e.stopPropagation();
    e.preventDefault();

    this.setState({submitting: true});

    Stripe.card.createToken({
      number: this.state.ccNumber,
      cvc: this.state.cvc,
      exp_month: this.state.expMonth,
      exp_year: this.state.expYear,
      name: this.state.name,
      address_zip: this.state.zip
    }, this.handleStripeResponse);
  }

  getTicketType = () => {
    const ticketTypeId = Number.parseInt(this.state.ticketTypeId);

    return this.props.ticketTypes.find((ticketType) => { return ticketType.id === ticketTypeId; });
  }

  handleStripeResponse = (status, response) => {
    if (response.error) {
      this.setState({
        paymentError: response.error.message,
        submitting: false
      });
    } else {
      this.setState({ stripeToken: response.id });

      fetch(this.props.createChargeUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHTTPRequest',
          'X-CSRF-Token': getCSRFToken()
        },
        body: JSON.stringify({
          stripeToken: this.state.stripeToken,
          ticket: {
            ticket_type_id: this.state.ticketTypeId,
            name: this.state.name,
            email: this.state.email,
            phone: this.state.phone
          }
        }),
        credentials: 'same-origin'
      }).then((response) => {
        if (response.status >= 200 && response.status < 300) {
          return response;
        } else {
          var error = new Error(response.statusText);
          error.response = response;
          throw error;
        }
      }).then((response) => {
        window.location.href = this.props.purchaseCompleteUrl;
      }).catch((error) => {
        this.setState({
          paymentError: error.message,
          submitting: false
        })
      });
    }
  }

  renderPaymentError = () => {
    if (!this.state.paymentError) {
      return null;
    }

    return (
      <div className="alert alert-danger">
        {this.state.paymentError}
      </div>
    );
  }

  renderTicketTypeSelect = () => {
    const options = this.props.ticketTypes.map((ticketType, i) => {
      let description = `${ticketType.name} (${ticketType.formattedPrice})`;
      if (!ticketType.available) {
        description += " - SOLD OUT";
      }

      return <option key={i} value={ticketType.id} disabled={!ticketType.available}>{description}</option>;
    });

    const id = this.nextUniqueId();

    return (
      <div className="form-group">
        <label htmlFor={id}>Ticket type</label>
        <select className="form-control" id={id} value={this.state.ticketTypeId} onChange={this.fieldChanged.bind(this, 'ticketTypeId')}>
          <option></option>
          {options}
        </select>
      </div>
    );
  }

  renderPaymentSection = () => {
    if (!this.state.ticketTypeId) {
      return null;
    }

    const nameId = this.nextUniqueId();
    const emailId = this.nextUniqueId();
    const phoneId = this.nextUniqueId();

    return (
      <div>
        {this.renderPaymentError()}

        <div className="form-group">
          <label htmlFor={nameId}>Name</label>
          <input className="form-control" id={nameId} type="text" value={this.state.name} onChange={this.fieldChanged.bind(this, 'name')} />
        </div>

        <div className="form-group">
          <label htmlFor={emailId}>Email</label>
          <input className="form-control" id={emailId} type="email" value={this.state.email} onChange={this.fieldChanged.bind(this, 'email')} />
        </div>

        <div className="form-group">
          <label htmlFor={phoneId}>Phone number</label>
          <input className="form-control" id={phoneId} type="email" value={this.state.phone} onChange={this.fieldChanged.bind(this, 'phone')} />
        </div>

        <PaymentEntry
          ccNumber={this.state.ccNumber}
          expMonth={this.state.expMonth}
          expYear={this.state.expYear}
          cvc={this.state.cvc}
          zip={this.state.zip}
          onCcNumberChanged={this.fieldChanged.bind(this, 'ccNumber')}
          onExpMonthChanged={this.fieldChanged.bind(this, 'expMonth')}
          onExpYearChanged={this.fieldChanged.bind(this, 'expYear')}
          onCvcChanged={this.fieldChanged.bind(this, 'cvc')}
          onZipChanged={this.fieldChanged.bind(this, 'zip')}
        />

        <button className="btn btn-primary" disabled={this.state.submitting} onClick={this.submitPayment}>
          Submit payment
          {this.renderSubmittingSpinner()}
        </button>
      </div>
    );
  }

  renderSubmittingSpinner = () => {
    if (!this.state.submitting) {
      return null;
    }

    return <i className={"fa fa-spinner fa-spin"}></i>;
  }

  render = () => {
    return (
      <form>
        {this.renderTicketTypeSelect()}
        {this.renderPaymentSection()}
      </form>
    );
  }
}

export default TicketPurchaseForm;