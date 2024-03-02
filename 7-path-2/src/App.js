import React from "react";
import ReactDOM from "react-dom/client";
import Header from "./components/Header";
import Body from "./components/Body";
import {
  BrowserRouter as Router,
  Outlet,
  Routes,
  Route,
} from "react-router-dom";
import About from "./components/About";
import Contact from "./components/Contact";
import Error from "./components/Error";
import RestuarantMenu from "./components/RestuarantMenu";

const AppLayout = () => {
  return (
    <>
      <div className="app">
        <Header />
        <Outlet />
      </div>
    </>
  );
};

// const appRouter = createBrowserRouter([
//   {
//     path: "/",
//     element: <AppLayout />,
//     errorElement: <Error />,
//     children: [
//       { path: "/", element: <Body /> },
//       { path: "/about", element: <About /> },
//       { path: "/contact", element: <Contact /> },
//       { path: "/restuatant/:resId", element: <RestuarantMenu /> },
//     ],
//   },
// ]);

const root = ReactDOM.createRoot(document.getElementById("root"));

root.render(
  <Router>
    <Routes>
      <Route path="/" element={<AppLayout />} errorElement={<Error />}>
        <Route path="/" element={<Body />} errorElement={<Error />} />
        <Route path="/about" element={<About />} />
        <Route path="/contact" element={<Contact />} />
        <Route path="/restuatant/:resId" element={<RestuarantMenu />} />
      </Route>
    </Routes>
  </Router>
);

// The errorElement property in your first example, which uses the BrowserRouter, Routes, and Route
// components from React Router v6, does not work as intended because React Router v6 does not support errorElement
// directly within the Route component in the same way that it is used in the createBrowserRouter configuration.
