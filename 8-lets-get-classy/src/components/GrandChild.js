import React from "react";
class GrandChild extends React.Component {
  constructor(props) {
    super(props);
    console.log("GrandChild constructor");
    this.state = {
      count: 3,
      count2: 6,
    };
  }
  render() {
    console.log("GrandChild render");
    return (
      <div className="team-member">
        <h2>Name {this.props.name} ---- From class comp</h2>
        <h3>Sr Software Devloper</h3>
        <h4>{this.state.count}</h4>
        <button
          onClick={() => {
            this.setState({ count: this.state.count + 1 });
          }}
        >
          update
        </button>
      </div>
    );
  }
  componentDidMount() {
    console.log("GrandChild mounted");
  }
  componentDidUpdate() {
    console.log("grandchild did update is called");
  }
}

export default GrandChild;
