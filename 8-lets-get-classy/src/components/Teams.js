import React, { useState } from "react";

const Teams = (props) => {
  let [data, setData] = useState(3);
  return (
    <div className="team-member">
      <h2>Name Raghav</h2>
      <h3>Sr Software Devloper</h3>
      {data}
      <button
        onClick={() => {
          data = data + 1;
          console.log(data);
        }}
      >
        Click
      </button>
      <button
        onClick={() => {
          setData(data + 1);
          console.log(data);
        }}
      >
        Click
      </button>
    </div>
  );
};

export default Teams;
