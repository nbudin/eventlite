import React, { PropTypes } from 'react';
import _ from 'lodash';
import CreditCardNumberInput from './CreditCardNumberInput';

class TicketPurchaseForm extends React.Component {
  static propTypes = {
    ticketTypes: PropTypes.arrayOf(
      PropTypes.shape({
        name: PropTypes.string.isRequired,
        price: PropTypes.number.isRequired,
        formattedPrice: PropTypes.string.isRequired
      })
    ).isRequired
  };

  constructor(props) {
    super(props);

    this.state = {
      paymentError: null,
      ccIconClass: 'fa fa-credit-card',
      submitting: false,
      stripeToken: null,
      ccNumber: "",
      cvc: "",
      expMonth: "",
      expYear: ""
    };
  }

  fieldChanged = (attribute, e) => {
    var stateChange = {};
    stateChange[attribute] = e.target.value;

    this.setState(stateChange);
  }

  submitPayment = (e) => {
    e.stopPropagation();
    e.preventDefault();

    this.setState({submitting: true});

    Stripe.card.createToken({
      number: this.state.ccNumber,
      cvc: this.state.cvc,
      exp_month: this.state.expMonth,
      exp_year: this.state.expYear
    }, this.handleStripeResponse);
  }

  handleStripeResponse = (status, response) => {
    var $form = $('[data-payment-form]');

    if (response.error) {
      this.setState({
        paymentError: response.error.message,
        submitting: false
      });
    } else {
      this.setState({ stripeToken: response.id });

      var ticketCreatePromise = $.ajax({
        url: this.props.ticketCreateUrl,
        method: 'POST',
        dataType: 'json',
        data: {
          stripeToken: this.state.stripeToken,
          ticket: {
            ticket_type_id: this.props.ticketTypeId
          }
        }
      });

      ticketCreatePromise.done(function(data, textStatus, jqXHR) {
        window.location.href = this.props.purchaseCompleteUrl;
      }.bind(this));

      ticketCreatePromise.fail(function(jqXHR, textStatus, errorThrown) {
        this.setState({
          paymentError: jqXHR.responseText,
          submitting: false
        });
      }.bind(this));
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

  renderSubmittingSpinner = () => {
    if (!this.state.submitting) {
      return null;
    }

    return <i className={"fa fa-spinner fa-spin"}></i>;
  }

  render = () => {
    var ccNumberId = _.uniqueId('cc_number_');
    var cvcId = _.uniqueId('cvc_');

    return <form>
      <div className="form-group">
        <label className="control-label">Price</label>
        <div className="form-control-static">
          {this.props.ticketPriceFormatted}
        </div>
      </div>

      <CreditCardNumberInput
        id={ccNumberId}
        value={this.state.ccNumber}
        onChange={this.fieldChanged.bind(this, 'ccNumber')}
      />

      <div className="row">
        <div className="col">
          <div className="form-group">
            <label className="control-label">Expiration date</label>
            <div className="row">
              <div className="col">
                <input type="tel" value={this.state.expMonth} onChange={this.fieldChanged.bind(this, 'expMonth')} className="form-control" size="2" placeholder="MM" />
              </div>
              <div className="col">
                <input type="tel" value={this.state.expYear} onChange={this.fieldChanged.bind(this, 'expYear')} className="form-control" size="4" placeholder="YYYY" />
              </div>
            </div>
          </div>
        </div>

        <div className="col">
          <div className="form-group">
            <label htmlFor={cvcId} className="control-label">CVC</label>
            <input type="tel" id={cvcId} value={this.state.cvc} onChange={this.fieldChanged.bind(this, 'cvc')} className="form-control" placeholder="•••" />
          </div>
        </div>
      </div>

      <button className="btn btn-primary" disabled={this.state.submitting} onClick={this.submitPayment}>
        Submit payment
        {this.renderSubmittingSpinner()}
      </button>
    </form>;
  }
}

export default TicketPurchaseForm;