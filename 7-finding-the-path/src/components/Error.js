import React from "react";
import { useRouteError } from "react-router-dom";

const Error = () => {
  const errorDetails = useRouteError();
  console.log(errorDetails);
  return (
    <div>
      Error!!!{" "}
      <h3>
        {errorDetails.status}:{errorDetails.statusText}
      </h3>
    </div>
  );
};

export default Error;
