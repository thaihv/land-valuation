import {
  MapContainer,
  TileLayer,
  WMSTileLayer,
  LayersControl,
  LayerGroup,
  FeatureGroup,
  Popup,
  Circle,
  Rectangle,
} from "react-leaflet";
import { useState } from "react";
import "./map.scss";
import "leaflet/dist/leaflet.css";
import Pin from "./Pin";

function Map({ items }) {
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const ZOOM_LEVEL = 6;
  return (
    <MapContainer
      center={center}
      zoom={ZOOM_LEVEL}
      scrollWheelZoom={true}
      className="map"
    >
      <TileLayer
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      <LayersControl position="topright">
        <LayersControl.Overlay checked name="Provinces">
          <LayerGroup>
            <WMSTileLayer
              layers={"lvis:province"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
              maxZoom={20}
              transparent={true}
              format="image/png"
              opacity={0.6}
            />
          </LayerGroup>  
        </LayersControl.Overlay>
        <LayersControl.Overlay checked name="Roads">
          <LayerGroup>
            <WMSTileLayer
              layers={"lvis:roads"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
              maxZoom={20}
              transparent={true}
              format="image/png"
              opacity={0.8}
            />
          </LayerGroup>  
        </LayersControl.Overlay>
        <LayersControl.Overlay checked name="Villages">
          <LayerGroup>
            <WMSTileLayer
              layers={"lvis:village"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
              maxZoom={20}
              transparent={true}
              format="image/png"
              opacity={0.85}
            />
          </LayerGroup>  
        </LayersControl.Overlay>                
        <LayersControl.Overlay name="Research Place">
          {items.map((item) => (
            <Pin item={item} key={item.id} />
          ))}
        </LayersControl.Overlay>
      </LayersControl>
    </MapContainer>
  );
}

export default Map;
