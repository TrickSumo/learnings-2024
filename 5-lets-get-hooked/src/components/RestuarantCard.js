const RestuarantCard = ({
  resName,
  cuisine,
  stars,
  time,
  imageURL,
  costForTwo,
}) => {
  return (
    <div className="res-card">
      <img className="res-logo" alt="res-logo" src={imageURL}></img>
      <h3>{resName}</h3>
      <h4>{cuisine}</h4>
      <h4>{`Cost For Two:- ${costForTwo}`}</h4>
      <h4>{stars} Stars</h4>
      <h4>{time} minutes</h4>
    </div>
  );
};

export default RestuarantCard;
