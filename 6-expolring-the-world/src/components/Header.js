import { useState } from "react";
import { logoURL } from "../utils/constants";

const Header = () => {
  const [auth, setAuth] = useState(false);
  return (
    <div className="header">
      <div className="logo">
        <img className="logo-img" src={logoURL}></img>
      </div>
      <div className="nav-items">
        <ul>
          <li>Home</li>
          <li>About Us</li>
          <li>Cart</li>
          <li>
            <button
              className="login-btn"
              onClick={() => {
                setAuth((curr) => !curr);
              }}
            >
              {auth ? "Logout" : "Login"}
            </button>
          </li>
        </ul>
      </div>
    </div>
  );
};

export default Header;
