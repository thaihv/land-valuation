import { MapContainer, Marker, TileLayer } from "react-leaflet";
import osm from "./osm-providers";
import "leaflet/dist/leaflet.css";

const marker = { lat: 19.8563, lng: 102.4955 };
const interactionOptions = {
  zoomControl: false,
  doubleClickZoom: false,
  closePopupOnClick: false,
  dragging: false,
  zoomSnap: false,
  zoomDelta: false,
  trackResize: false,
  touchZoom: false,
  scrollWheelZoom: false,
};

const StaticMap = () => {
  return (
    <MapContainer center={marker} zoom={12} className="map" {...interactionOptions}>
    <TileLayer url={osm.maptiler.url} />
    <Marker position={[marker.lat, marker.lng]}></Marker>
  </MapContainer>
  );
};

export default StaticMap;
