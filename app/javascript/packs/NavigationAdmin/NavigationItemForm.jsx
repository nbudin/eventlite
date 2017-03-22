import React, { PropTypes } from 'react';

class NavigationItemForm extends React.Component {
  static propTypes = {
    initialNavigationItem: PropTypes.shape({
      parent_id: PropTypes.number,
      item_type: PropTypes.string.isRequired,
      title: PropTypes.string
    }).isRequired,
    isNew: PropTypes.bool.isRequired,
    pages: PropTypes.arrayOf(
      PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired
      })
    ).isRequired
  };

  constructor(props) {
    super(props);

    this.state = {
      navigationItem: props.initialNavigationItem
    };
  }

  renderItemTypeSelect = () => {
    if (!this.props.isNew || this.state.navigationItem.parent_id) {
      return null;
    }

    return (
      <div className="form-group">
        <label className="form-control-label">Item type</label>
        <select className="form-control">
          <option value="section">section</option>
          <option value="link">link</option>
        </select>
      </div>
    );
  }

  renderPageSelect = () => {
    if (this.state.navigationItem.item_type === 'section') {
      return null;
    }

    const options = this.props.pages.map((page, i) => {
      return <option value={page.id} key={i}>{page.name}</option>;
    });

    return (
      <div className="form-group">
        <label className="form-control-label">Page</label>
        <select className="form-control">{options}</select>
      </div>
    );
  }

  render() {
    return (
      <form>
        {this.renderItemTypeSelect()}

        <div className="form-group">
          <label className="form-control-label">Title</label>
          <input className="form-control" type="text" value={this.state.navigationItem.title} />
        </div>

        {this.renderPageSelect()}
        <input type="submit" className="btn btn-primary" value="Save"/>
      </form>
    );
// = bootstrap_form_for [@event, navigation_item], html: { class: 'navigation_item_form' } do |f|
//   = f.hidden_field :parent_id
//   - unless navigation_item.parent || navigation_item.persisted?
//     = f.select :item_type, ['section', 'link']
//   = f.text_field :title
//   - if navigation_item.item_type == 'link' || (!navigation_item.parent && navigation_item.new_record?)
//     = f.collection_select :page_id, @event.pages.order(:name), :id, :name, prompt: ''
//   = f.submit class: 'btn btn-primary'
  }
}

export default NavigationItemForm;