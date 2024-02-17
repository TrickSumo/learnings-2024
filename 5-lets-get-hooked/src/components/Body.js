import RestuarantCard from "./RestuarantCard";
import { data, cloudinaryURL } from "../utils/constants";
import { useState } from "react";

const Body = () => {
  const [resData, setResData] = useState(data);
  return (
    <div className="body">
      <div className="filter" key="filter">
        <button
          className="filter-btn"
          onClick={() => {
            setResData((curr) =>
              curr.filter((res) => res.info.avgRating > 4.2)
            );
          }}
        >
          Filter Top Rated
        </button>
      </div>
      <div className="res-container" k="res">
        {resData.map((res) => (
          <RestuarantCard
            key={res.id}
            resName={res.info.name}
            cuisine={res.info.cuisines.join(", ")}
            stars={res.info.avgRating}
            time={res.info.sla.deliveryTime}
            imageURL={cloudinaryURL + res.info.cloudinaryImageId}
            costForTwo={res.info.costForTwo}
          />
        ))}
      </div>
    </div>
  );
};

export default Body;
