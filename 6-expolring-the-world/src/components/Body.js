import RestuarantCard from "./RestuarantCard";
import { data, cloudinaryURL } from "../utils/constants";
import { useEffect, useState } from "react";
import Shimmer from "./Shimmer";

const Body = () => {
  const [resData, setResData] = useState([]);

  useEffect(() => {
    console.log("Use Effect called");
    fetchData();
  }, []);
  console.log("Page Rendered");

  const fetchData = async () => {
    let res = await fetch(
      "https://www.swiggy.com/dapi/restaurants/list/v5?lat=22.96440&lng=76.04730&is-seo-homepage-enabled=true&page_type=DESKTOP_WEB_LISTING"
    );
    res = await res.json();
    console.log(
      res.data.cards[1].card.card.gridElements.infoWithStyle.restaurants
    );
    setResData(
      res?.data?.cards[1]?.card?.card?.gridElements?.infoWithStyle?.restaurants
    );
  };

  return resData?.length === 0 ? (
    <Shimmer />
  ) : (
    <div className="body">
      <div className="filter" key="filter">
        <div className="search">
          <input type="text" className="search-box" />
          <button>Search</button>
        </div>
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
            key={res?.id}
            resName={res?.info?.name}
            cuisine={res?.info?.cuisines?.join(", ")}
            stars={res?.info?.avgRating}
            time={res?.info?.sla?.deliveryTime}
            imageURL={cloudinaryURL + res?.info?.cloudinaryImageId}
            costForTwo={res?.info?.costForTwo}
          />
        ))}
      </div>
    </div>
  );
};

export default Body;
