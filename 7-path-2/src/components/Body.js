import RestuarantCard from "./RestuarantCard";
import { data, cloudinaryURL } from "../utils/constants";
import { useEffect, useState } from "react";
import Shimmer from "./Shimmer";
import { Link } from "react-router-dom";

const Body = () => {
  const [filteredResData, setFilteredResData] = useState([]);
  const [resData, setResData] = useState([]);
  const [searchKeyword, setSearchKeyword] = useState("");

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
    console.log(res.data.cards[1].card.card);
    setResData(
      res?.data?.cards[1]?.card?.card?.gridElements?.infoWithStyle?.restaurants
    );
    setFilteredResData(
      res?.data?.cards[1]?.card?.card?.gridElements?.infoWithStyle?.restaurants
    );
  };

  const handleSearch = () => {
    // if (searchKeyword.length > 0) {
    console.log(
      "after search",
      resData.filter((res) =>
        res?.info?.name?.toLowerCase().includes(searchKeyword.toLowerCase())
      )
    );
    setFilteredResData(() =>
      resData.filter((res) =>
        res?.info?.name?.toLowerCase().includes(searchKeyword.toLowerCase())
      )
    );
    // }
  };

  return resData?.length === 0 ? (
    <>
      {/* <Shimmer /> <button onClick={() => console.log(resData)}>Console Log State</button> */}
    </>
  ) : (
    <div className="body">
      {/* <button onClick={() => console.log(filteredResData)}>Console Log State</button> */}
      <div className="filter" key="filter">
        <div className="search">
          <input
            type="text"
            className="search-box"
            value={searchKeyword}
            onChange={(e) => setSearchKeyword(e.target.value)}
          />
          <button onClick={() => handleSearch()}>Search</button>
        </div>
        <button
          className="filter-btn"
          onClick={() => {
            setFilteredResData(() =>
              resData.filter((res) => res.info.avgRating > 4.2)
            );
          }}
        >
          Filter Top Rated
        </button>
      </div>
      <div className="res-container" k="res">
        {/* {console.log(filteredResData)} */}
        {filteredResData.length > 0
          ? filteredResData.map((res) => (
              <Link to={`/restuatant/${res?.info?.id}`}>
                <RestuarantCard
                  key={res?.id}
                  resName={res?.info?.name}
                  cuisine={res?.info?.cuisines?.join(", ")}
                  stars={res?.info?.avgRating}
                  time={res?.info?.sla?.deliveryTime}
                  imageURL={cloudinaryURL + res?.info?.cloudinaryImageId}
                  costForTwo={res?.info?.costForTwo}
                />
              </Link>
            ))
          : "No Restuarant Found!"}
      </div>
    </div>
  );
};

export default Body;
