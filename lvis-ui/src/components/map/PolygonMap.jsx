import React, { useState } from "react";

import { MapContainer, TileLayer, FeatureGroup } from "react-leaflet";
import { EditControl } from "react-leaflet-draw";
import osm from "./osm-providers";
import "leaflet/dist/leaflet.css";
import "leaflet-draw/dist/leaflet.draw.css";

const PolygonMap = () => {
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const [mapLayers, setMapLayers] = useState([]);
  const ZOOM_LEVEL = 12;

  const _onCreate = (e) => {
    console.log(e);

    const { layerType, layer } = e;
    if (layerType === "polygon") {
      const { _leaflet_id } = layer;

      setMapLayers((layers) => [
        ...layers,
        { id: _leaflet_id, latlngs: layer.getLatLngs()[0] },
      ]);
    }
  };

  const _onEdited = (e) => {
    console.log(e);
    const {
      layers: { _layers },
    } = e;

    Object.values(_layers).map(({ _leaflet_id, editing }) => {
      setMapLayers((layers) =>
        layers.map((l) =>
          l.id === _leaflet_id
            ? { ...l, latlngs: { ...editing.latlngs[0] } }
            : l
        )
      );
    });
  };

  const _onDeleted = (e) => {
    console.log(e);
    const {
      layers: { _layers },
    } = e;

    Object.values(_layers).map(({ _leaflet_id }) => {
      setMapLayers((layers) => layers.filter((l) => l.id !== _leaflet_id));
    });
  };

  return (
    <MapContainer center={center} zoom={ZOOM_LEVEL} className="map">
      <FeatureGroup>
        <EditControl
          position="topright"
          onCreated={_onCreate}
          onEdited={_onEdited}
          onDeleted={_onDeleted}
          draw={{
            rectangle: false,
            polyline: false,
            circle: false,
            circlemarker: false,
            marker: false,
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

export default PolygonMap;
