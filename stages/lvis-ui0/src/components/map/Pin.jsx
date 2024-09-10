import { Marker, Popup } from "react-leaflet";
import "./pin.scss";
import { Link } from "react-router-dom";
import { styled } from "@mui/system";
import {
  useTheme,
} from "@mui/material";

const StyledPop = styled(Popup)(({ theme }) => ({
  
  backgroundColor: "red",
  borderRadius: "5%",
  "& .leaflet-popup-content-wrapper": {
    paddingTop: "20px",
    borderRadius: "5%",
    backgroundColor: theme.palette.secondary.alt,
    border: "2.5px solid",
    borderColor: theme.palette.success.main
  },
  "& .leaflet-popup-content": {
    margin: "0px 0px 0px 0px",
  },  
  "& .leaflet-popup-tip-container": {
    left: "15%",
  },
  "& .leaflet-popup-tip": {
    backgroundColor: theme.palette.success.main,
  },
})
);

function Pin({ item }) {
  const theme = useTheme();
  return (
    <Marker position={[item.latitude, item.longitude]}>
      <StyledPop theme = {theme}>
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
