import { Marker, Popup } from "react-leaflet";
import "./pin.scss";
import { Link } from "react-router-dom";
import { styled } from "@mui/system";

const StyledPop = styled(Popup)({
  backgroundColor: "red",
  borderRadius: "5%",
  "& .leaflet-popup-content-wrapper": {
    padding: "2px",
    borderRadius: "5%",
    border: "2.5px solid green",
  },
  "& .leaflet-popup-content": {
    borderRadius: "5%",
    margin: "0px 0px 0px 0px",
  },  
  "& .leaflet-popup-tip-container": {
    left: "15%",
  },
  "& .leaflet-popup-tip": {
    backgroundColor: "green",
  },
});

function Pin({ item }) {
  return (
    <Marker position={[item.latitude, item.longitude]}>
      <StyledPop>
        <div className="popupContainer">
          <img src={item.images[0]} alt="" />
          <div className="textContainer">
            <Link to={`/${item.id}`}>{item.title}</Link>
            <span>{item.bedroom} bedroom</span>
            <b>$ {item.price}</b>
          </div>
        </div>
      </StyledPop>
    </Marker>
  );
}

export default Pin;
