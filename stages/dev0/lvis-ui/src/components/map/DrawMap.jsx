import React, { useState } from "react";
import { MapContainer, TileLayer, FeatureGroup } from "react-leaflet";
import { EditControl } from "react-leaflet-draw";
import osm from "./osm-providers";
import "leaflet/dist/leaflet.css";
import "leaflet-draw/dist/leaflet.draw.css";

const DrawMap = () => {
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const ZOOM_LEVEL = 12;
  const _created = (e) => console.log(e);
  return (
    <MapContainer center={center} zoom={ZOOM_LEVEL} className="map">
      <FeatureGroup>
        <EditControl
          position="topright"
          onCreated={_created}
          draw={{
            rectangle: false,
            circle: false,
            circlemarker: false,
            marker: true,
            polyline: true,
          }}
        />
      </FeatureGroup>
      <TileLayer
        url={osm.maptiler.url}
        attribution={osm.maptiler.attribution}
      />
    </MapContainer>
  );
};

export default DrawMap;
