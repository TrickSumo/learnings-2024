import React, { useEffect, useState } from "react";
import Shimmer from "./Shimmer";
import { useParams } from "react-router-dom";
import { resInfoURL } from "../utils/constants";

const RestuarantMenu = () => {
  const [resInfo, setResInfo] = useState(null);
  const { resId } = useParams();
  useEffect(() => {
    fetchMenu();
  }, []);
  const fetchMenu = async () => {
    console.log(resInfoURL + resId, resId);
    res = await fetch(resInfoURL + resId);
    const menuData = await res.json();
    setResInfo(menuData.data.cards[2].card.card.info);
    console.log(menuData.data.cards[2].card.card.info, resId);
  };
  return resInfo === null ? (
    <Shimmer />
  ) : (
    <div className="menu">
      <h1>Menu</h1>
      <h1>{resInfo.name}</h1>
      <h3>{resInfo.cuisines.join(", ")}</h3>
      <h3>{resInfo.costForTwoMessage}</h3>
      <ul>
        <li>a</li>
        <li>b</li>
        <li>c</li>
      </ul>
    </div>
  );
};

export default RestuarantMenu;
