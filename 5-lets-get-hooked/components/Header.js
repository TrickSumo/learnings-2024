import { logoURL } from "../utils/constants";

const Header = () => {
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
        </ul>
      </div>
    </div>
  );
};

export default Header;
