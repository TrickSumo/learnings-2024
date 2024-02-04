import React from "react";
import ReactDOM from "react-dom/client";

// React Element   ===after render===> HTML element

const ele = React.createElement("h1", { id: "heading" }, "Simple string 🚀");

//JSX

const jsxEle = <h1 id="heading">Simple string 🚀</h1>;

// console.log(ele, jsxEle);

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(jsxEle);
// multiline JSX

const jsxEle2 = (
  <h1 id="heading" className="" onClick={() => {}}>
    Simple string 🚀
  </h1>
);

// React Functional component

const HeadingComponent = () => {
  return <h1 id="heading">Simple string 🚀 React Functional component</h1>;
};

const HeadingComponent2 = () => (
  <h1 id="heading">Simple string 🚀 React Functional component2</h1>
);

root.render(<HeadingComponent />);
