import RestuarantCard from "./RestuarantCard";
import { data, cloudinaryURL } from "../utils/constants";
import { useEffect, useState, useRef } from "react";
import Shimmer from "./Shimmer";
import { Link } from "react-router-dom";
import { set } from "express/lib/application";

const Body = () => {
  const [filteredResData, setFilteredResData] = useState([]);
  const [resData, setResData] = useState([]);
  const [searchKeyword, setSearchKeyword] = useState("");
  const [filterEnabled, setFilterEnabled] = useState(false);
  const [loading, setLoading] = useState(false);

  const ref = useRef(null);

  console.log("Page Rendered");

  const handleSearch = (searchKey) => {
    setLoading(true);
    setSearchKeyword(searchKey);

    // If timer exist, remove it thus clearing previous search
    if (ref.current) {
      clearTimeout(ref.current);
    }

    ref.current = setTimeout(() => {
      console.log("Search Happened");
      setLoading(false);
      setFilteredResData(() =>
        resData.filter((res) =>
          res?.info?.name?.toLowerCase().includes(searchKey.toLowerCase())
        )
      );
    }, 300);
  };

  const handleFilter = () => {
    if (filterEnabled) {
      handleSearch(searchKeyword);
      setFilterEnabled(false);
    } else {
      setFilteredResData((prev) =>
        prev.filter((res) => res.info.avgRating > 4.2)
      );
      setFilterEnabled(true);
    }
  };

  useEffect(() => {
    const fetchData = async () => {
      let res = await fetch(
        "https://www.swiggy.com/dapi/restaurants/list/v5?lat=22.96440&lng=76.04730&is-seo-homepage-enabled=true&page_type=DESKTOP_WEB_LISTING"
      );
      res = await res.json();
      console.log(res.data.cards[1]);
      setResData(
        res?.data?.cards[1]?.card?.card?.gridElements?.infoWithStyle
          ?.restaurants
      );
      setFilteredResData(
        res?.data?.cards[1]?.card?.card?.gridElements?.infoWithStyle
          ?.restaurants
      );
    };
    fetchData();

    // Clearing the timeout on component unmount
    return () => {
      if (ref.current) {
        clearTimeout(ref.current);
      }
    };
  }, []);

  return resData?.length === 0 ? (
    <>
      <Shimmer />
    </>
  ) : (
    <div className="body">
      <div className="filter" key="filter">
        <div className="search">
          <input
            type="text"
            className="search-box"
            value={searchKeyword}
            onChange={(e) => handleSearch(e.target.value)}
          />
          <button onClick={() => handleSearch("")}>X</button>
        </div>
        <button className="filter-btn" onClick={handleFilter}>
          {filterEnabled ? "Clear Filter" : "Filter Top Rated"}
        </button>
      </div>
      <div className="res-container" k="res">
        {loading ? (
          "Searching for Restuarants..."
        ) : (
          <>
            {filteredResData?.length > 0
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
          </>
        )}
      </div>
    </div>
  );
};

export default Body;
