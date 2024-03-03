import React from "react";
class TeamsClassComp extends React.Component {
  constructor(props) {
    super(props);
    console.log("Child1 constructor");
    this.state = {
      count: 3,
      count2: 6,
    };
  }
  render() {
    console.log("Child1 render");
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
    console.log("child1 mounted");
  }
  componentDidUpdate() {
    console.log("child did update is called");
  }
}

export default TeamsClassComp;
