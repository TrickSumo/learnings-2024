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

const num = 9000;

//Component Composition => one functional component is used in another
const Title = () => {
  return <h1 id="heading">Simple string 🚀 React Functional component2</h1>;
};
const HeadingComponent2 = () => {
  return (
    <div>
      <Title />
      <div>Paragraph here</div>
      Power level over {num}
    </div>
  );
};

root.render(<HeadingComponent2 />);

//Putting react element insdie react functionlal component
const title = <h1 id="heading">Simple string 🚀 React element</h1>;

const HeadingComponent3 = () => {
  return (
    <div>
      {title}
      <div>Paragraph here</div>
      Power level over {num}
    </div>
  );
};

root.render(<HeadingComponent3 />);

//infinite loop

// const HeadingComponent4 = () => {
//   return (
//     <div>
//       {title4}
//       <div>Paragraph here</div>
//       Power level over {num}
//     </div>
//   );
// };
// const title4 = (
//   <h1 id="heading">Simple string 🚀 React element {<HeadingComponent4 />}</h1>
// );

// root.render(<HeadingComponent4 />);

// functional component inside react element

const HeadingComponent4 = () => {
  return (
    <div>
      <div>Paragraph here</div>
      Power level over {num}
    </div>
  );
};
const title4 = (
  <div id="heading">Simple string 🚀 React element {<HeadingComponent4 />}</div>
);

root.render(title4);

//Three ways to call functional component

const Title6 = () => {
  return <h1 id="heading">Simple string 🚀 React Functional component2</h1>;
};
const HeadingComponent6 = () => {
  return (
    <div>
      <Title6 />
      <Title6></Title6>
      {Title6()}
      <div>Paragraph here</div>
      Power level over {num}
    </div>
  );
};
root.render(<HeadingComponent6 />);
