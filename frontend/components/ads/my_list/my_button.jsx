var React = require('react');
var PropTypes = React.PropTypes;
var MyListStore = require('../../../stores/my_list_store.js');
var AdStore = require('../../../stores/ad_store.js');
var ApiUtil = require('../../../util/api_util');
var AdActions = require('../../../actions/ad_actions');
// this is the button that toggles ads listed on MyList
// it requires an ad id to function

var MyListButton = React.createClass({
  getInitialState: function() {
    return {
      onMyList: this.checkIfFavorited(),
      hover: false
    };
  },

  componentDidMount: function() {
    this.token = MyListStore.addListener(this.getStateFromStore);
    this.adToken = AdStore.addListener(this.getStateFromStore);
  },

  componentWillUnmount: function() {
    this.token.remove();
    this.adToken.remove();
  },

  checkIfFavorited: function () {
    return MyListStore.includes(this.props.ad);
  },

  getStateFromStore: function () {
    this.setState({ onMyList: this.checkIfFavorited() });
  },

  toggleList: function (e) {
    e.stopPropagation();
    if (!this.state.onMyList) {
      ApiUtil.addToMyList(this.props.ad);
    } else {
      ApiUtil.removeFromMyList(this.props.ad);
      if (this.props.ad.rowID === "MyList") {
        AdActions.closeDetails();
      }
    }
  },

  onHover: function () {
    this.setState({ hover: true });
  },

  offHover: function () {
    this.setState({ hover: false });
  },

  render: function() {
    var hover = "", klass = this.state.onMyList ? "check" : "plus";
    var value = this.state.onMyList ? "Remove" : "MyList";
    if (this.props.showFull) {
      if (this.state.hover) {
        hover = "-hover";
      }
      return (
        <button className="my-word-box light-box"
          onMouseEnter={this.onHover}
          onMouseLeave={this.offHover}
          onClick={this.toggleList}>
          <div className={"detail-my-list-btn " + klass+"-btn"+hover}/>
          <p>{value}</p>
        </button>
      );
    } else {
      return (
        <button className={"detail-my-list-btn " + klass}
          onMouseEnter={this.onHover}
          onMouseLeave={this.offHover}
          onClick={this.toggleList}/>
      );
    }
  }

});

module.exports = MyListButton;
