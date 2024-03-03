import React from "react";
import Teams from "./Teams";
import TeamsClassComp from "./TeamsClassComp";
import TeamsClassComp2 from "./TeamsClassComp2";

// const About = () => {
//   return (
//     <div>
//       <h1>About Us</h1>
//       We are best restuarant!
//       <Teams />
//       {/* <TeamsClassComp name={"Mohan"} /> */}
//     </div>
//   );
// };

class About extends React.Component {
  constructor(props) {
    super(props);
    console.log("PArent constructor");
    this.state = {
      name: "",
    };
  }
  render() {
    console.log("Parent render");
    return (
      <div>
        <h1>About Us</h1>
        We are best restuarant!
        {/* <Teams /> */}
        <TeamsClassComp name={this.state.name || "Mohan"} />
        <TeamsClassComp2 />
      </div>
    );
  }
  async componentDidMount() {
    console.log("Parent mounted - time for side effect");
    const res = await fetch("https://api.github.com/users/tricksumo");
    const data = await res.json();
    console.log(data);
    this.setState({ name: data.login });

    this.timer = setInterval(() => {
      console.log("10 secs");
    }, 1000);
  }
  componentDidUpdate() {
    console.log("Parent did update is called");
  }
  componentWillUnmount() {
    clearInterval(this.timer);
    console.log("Unmounting about us!");
  }
}

export default About;
