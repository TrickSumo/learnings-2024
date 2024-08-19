import { useState } from "react";
import { logoURL } from "../utils/constants";
import { Link } from "react-router-dom";
import useOnlineStatus from "../utils/useOnlineStatus";

const Header = () => {
  const [auth, setAuth] = useState(false);
  const online = useOnlineStatus();
  return (
    <div className="header">
      <div className="logo">
        <img className="logo-img" src={logoURL}></img>
      </div>
      <div className="nav-items">
        <ul>
          <li>{online ? "🟢" : "🔴"}</li>
          <li>
            <Link to="/">Home</Link>
          </li>
          <li>
            <Link to="/about">About Us</Link>
          </li>
          <li>
            <Link to="/contact">Cart</Link>
          </li>
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
