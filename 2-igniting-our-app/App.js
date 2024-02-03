import React from "react";
import ReactDOM from "react-dom/client";

const heading = React.createElement(
  "h1",
  { id: "myheading" },
  "Hello World From REACT!"
);

console.log(heading);
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(heading);

//////////////////////////////////////////////////////////////
////////////////////////////////Nested Elements
//////////////////////////////////////////////////////////////
const nestedElements = React.createElement(
  "div",
  { id: "parent" },

  React.createElement(
    "div",
    { id: "child" },
    React.createElement("h1", { id: "grandChild" }, "I am h1")
  )
);

const root2 = ReactDOM.createRoot(document.getElementById("root2"));
root2.render(nestedElements);

//////////////////////////////////////////////////////////////
////////////////////////////////Sibling Elements
//////////////////////////////////////////////////////////////

const SiblingElements = React.createElement(
  "div",
  { id: "parent" },

  React.createElement("div", { id: "child" }, [
    React.createElement("h1", { id: "grandChild1" }, "I am h1"),
    React.createElement("h2", { id: "grandChild2" }, "I am h2"),
  ])
);

const root3 = ReactDOM.createRoot(document.getElementById("root3"));
root3.render(SiblingElements);
