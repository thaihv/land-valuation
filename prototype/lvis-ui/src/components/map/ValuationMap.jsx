import React, { useState, useEffect } from 'react';
import { MapContainer, TileLayer, ScaleControl, WMSTileLayer, LayerGroup, Rectangle, useMapEvent, useMap } from 'react-leaflet';
import { useTheme } from '@mui/material';
import 'leaflet/dist/leaflet.css';
import Toolbar from "./toolbar/Toolbar"

const WatermarkControl = ({ theme, imgUrl, text }) => {
  const map = useMap();
  useEffect(() => {
    const Watermark = L.Control.extend({
      onAdd: () => {
        const div = L.DomUtil.create('div', 'leaflet-watermark');
        if (imgUrl) {
          const img = document.createElement('img');
          img.src = imgUrl;
          img.style.width = '40px'; // Adjust as needed
          div.appendChild(img);
        }
        if (text) {
          const watermarkText = document.createElement('div');
          watermarkText.innerHTML = text;
          watermarkText.style.fontSize = '12px';
          watermarkText.style.color = theme.palette.background.alt;
          watermarkText.style.fontWeight = 'bold';
          watermarkText.style.backgroundColor = 'transparent';
          div.appendChild(watermarkText);
        }
        return div;
      },
      onRemove: () => { }
    });

    const watermarkControl = new Watermark({ position: 'bottomleft' });
    map.addControl(watermarkControl);

    return () => {
      map.removeControl(watermarkControl); // Clean up on component unmount
    };
  }, [map, imgUrl, text]);

  return null;
};

const ValuationMap = () => {
  const theme = useTheme();
  // Extent of Lao project site for land valuation
  const extent = L.latLngBounds(
    [18.312810, 102.3046875],
    [17.978733, 103.0078125]
  );  
  const [baseLayers, setBaseLayers] = useState([
    { name: 'Open Street Map', active: true },
    { name: 'Open Topo Map', active: false },
  ]);
  const [overlays, setOverlays] = useState([
    { name: 'Province', visible: true },
    { name: 'District', visible: true },
    { name: 'Village', visible: true },
    { name: 'Road', visible: false },
    { name: 'Parcel', visible: false },
    { name: 'Valuation Object', visible: false },
  ]);
  const handleBaseLayerChange = (layerName) => {
    setBaseLayers((prev) =>
      prev.map((layer) =>
        layer.name === layerName
          ? { ...layer, active: true }
          : { ...layer, active: false }
      )
    );
  };  
  const handleOverlayToggle = (layerName) => {
    setOverlays((prev) =>
      prev.map((layer) =>
        layer.name === layerName
          ? { ...layer, visible: !layer.visible }
          : layer
      )
    );
  };
  return (
    <div style={{ position: 'relative', height: '100vh' }}>
      <MapContainer
        zoomControl={false}
        bounds={extent}
        style={{ height: '100%', width: '100%' }}
      >
        {/* Base Layers */}
        {baseLayers[0].active && (
          <TileLayer
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            attribution="Open Street Map"
            zIndex={1}
          />
        )}
        {baseLayers[1].active && (
          <TileLayer
            url="https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png"
            attribution="Open Topo Map"
            zIndex={1}
          />
        )}
        {/* Overlay Layers */}
        <LayerGroup>
          {overlays[0].visible && (
            <WMSTileLayer
              layers={"lvis:province"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
              maxZoom={20}
              transparent={true}
              styles="province"
              format="image/png"
              opacity={0.6}
              zIndex={2}
            />
          )}
          {overlays[1].visible && (
            <WMSTileLayer
              layers={"lvis:district"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
              maxZoom={20}
              transparent={true}
              styles="district"
              format="image/png"
              opacity={0.8}
              zIndex={3}
            />
          )}
          {overlays[2].visible && (
            <WMSTileLayer
              layers={"lvis:village"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
              maxZoom={20}
              transparent={true}
              styles="village"
              format="image/png"
              opacity={0.85}
              zIndex={4}
            />
          )}
          {overlays[3].visible && (
            <WMSTileLayer
              layers={"lvis:road"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
              maxZoom={20}
              transparent={true}
              styles="road"
              format="image/png"
              opacity={1}
              layerName="Road"
              zIndex={5}
            />
          )}
          {overlays[4].visible && (
            <WMSTileLayer
              layers={"lvis:parcel_re"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
              maxZoom={20}
              transparent={true}
              format="image/png"
              opacity={0.6}
              zIndex={6}
            />
          )}
          {overlays[5].visible && (
            <WMSTileLayer
              layers={"lvis:parcel_tech"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
              maxZoom={20}
              transparent={true}
              styles="parcel_tech"
              tiled={true}
              format="image/png"
              opacity={0.6}
              zIndex={6}
              attribution="Map data: © Generated by Lao Land Valuation Team"
            />
          )}
        </LayerGroup>
        <Toolbar
          baseLayers={baseLayers}
          overlays={overlays}
          onBaseLayerChange={handleBaseLayerChange}
          onOverlayToggle={handleOverlayToggle}
          extent={extent}
        />
        <WatermarkControl
          theme={theme}
          imgUrl="./org.png" // Replace with your image URL
          text="MONRE"
        />
        <ScaleControl position="bottomright" imperial={false} />
      </MapContainer>
    </div>
  );
};

export default ValuationMap;