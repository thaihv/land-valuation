import {
  MapContainer,
  TileLayer,
  WMSTileLayer,
  LayersControl,
} from "react-leaflet";
import Grid from "@mui/material/Grid2";
import { useState } from "react";
import "./map.scss";
import "leaflet/dist/leaflet.css";
import Pin from "./Pin";
import { Box, Typography, useTheme } from "@mui/material";
import FlexBetween from "../FlexBetween";
import AdjustOutlinedIcon from "@mui/icons-material/AdjustOutlined";
import MyLocationIcon from "@mui/icons-material/MyLocation";

function Map({ items }) {
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const ZOOM_LEVEL = 6;
  const [map, setMap] = useState(null);
  const theme = useTheme();
  function CustomControler() {
    const onClick = () => map.flyTo(center, ZOOM_LEVEL);
    const onLocation = () => {
      console.log("here");
    };
    return (
      <Box
        position="absolute"
        m="0 auto"
        p="5px"
        display="flex"
        flexDirection="column"
        justifyContent="center"
        backgroundColor={theme.palette.background.default}
        borderRadius="4px"
        gap="0.25rem"
        sx={{
          zIndex: "drawer",
          right: 10,
          top: "30%",
        }}
      >
        <FlexBetween
          onClick={onClick}
          sx={{
            color: theme.palette.secondary[100],
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <AdjustOutlinedIcon />
          <Typography sx={{ ml: "5px" }}>Center</Typography>
        </FlexBetween>
        <FlexBetween
          onClick={onLocation}
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <MyLocationIcon />
          <Typography sx={{ ml: "5px" }}>Location</Typography>
        </FlexBetween>
      </Box>
    );
  }

  return (
    <>
      <Grid container width="100%" height="100%">
        <Grid size={{ xs: 12, sm: 12, md: 12 }}>
          <MapContainer
            center={center}
            zoom={ZOOM_LEVEL}
            scrollWheelZoom={true}
            className="map"
            ref={setMap}
          >
            <TileLayer
              attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            />
            <LayersControl position="topright">
              <LayersControl.Overlay name="Province">
                <WMSTileLayer
                  layers={"lvis:province"}
                  url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
                  maxZoom={20}
                  transparent={true}
                  styles="province"
                  format="image/png"
                  opacity={0.6}
                />
              </LayersControl.Overlay>
              <LayersControl.Overlay checked name="District">
                <WMSTileLayer
                  layers={"lvis:district"}
                  url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
                  maxZoom={20}
                  transparent={true}
                  styles="district"
                  format="image/png"
                  opacity={0.8}
                />
              </LayersControl.Overlay>
              <LayersControl.Overlay name="Village">
                <WMSTileLayer
                  layers={"lvis:village"}
                  url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
                  maxZoom={20}
                  transparent={true}
                  styles="village"
                  format="image/png"
                  opacity={0.85}
                />
              </LayersControl.Overlay>
              <LayersControl.Overlay name="Road">
                <WMSTileLayer
                  layers={"lvis:road"}
                  url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
                  maxZoom={20}
                  transparent={true}
                  styles="road"
                  format="image/png"
                  opacity={1}
                />
              </LayersControl.Overlay>
              <LayersControl.Overlay name="Parcel">
                <WMSTileLayer
                  layers={"lvis:parcel_re"}
                  url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
                  maxZoom={20}
                  transparent={true}
                  format="image/png"
                  opacity={0.6}
                />
              </LayersControl.Overlay>
              <LayersControl.Overlay name="Valuation Object">
                <WMSTileLayer
                  layers={"lvis:parcel_tech"}
                  url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
                  maxZoom={20}
                  transparent={true}
                  styles="parcel_tech"
                  tiled={true}
                  format="image/png"
                  opacity={0.6}
                />
              </LayersControl.Overlay>
              <LayersControl.Overlay checked name="Research Place">
                {items.map((item) => (
                  <Pin item={item} key={item.id} />
                ))}
              </LayersControl.Overlay>
            </LayersControl>
            <CustomControler />
          </MapContainer>
        </Grid>
      </Grid>
    </>
  );
}
export default Map;
