import React, { useState, useRef } from 'react';
import { MapContainer, TileLayer } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { Box, IconButton, Tooltip } from '@mui/material';
import ZoomInIcon from '@mui/icons-material/ZoomIn';
import ZoomOutIcon from '@mui/icons-material/ZoomOut';
import MyLocationIcon from '@mui/icons-material/MyLocation';

const MapStyledToolbar = () => {
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const ZOOM_LEVEL = 6;
  const [map, setMap] = useState(null);

  const handleZoomIn = () => {
    map.zoomIn();
  }
  const handleZoomOut = () => {
    map.zoomOut();
  }
  const handleLocationTo = () => {
    map.flyTo(center, ZOOM_LEVEL);
  }
  return (
    <div style={{ position: 'relative', height: '75vh' }}>
      <MapContainer
        center={center}
        zoom={ZOOM_LEVEL}
        style={{ height: '100%', width: '100%' }}
        ref={setMap}
      >
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          attribution="&copy; OpenStreetMap contributors"
        />
      </MapContainer>
      <Box
        sx={{
          position: 'absolute',
          top: '10px',
          right: '10px',
          display: 'flex',
          flexDirection: 'column',
          backgroundColor: 'rgba(255, 255, 255, 0.8)',
          padding: '10px',
          borderRadius: '8px',
          zIndex: '1001',
        }}
      >
        <Tooltip title="Zoom In">
          <IconButton onClick={handleZoomIn}>
            <ZoomInIcon />
          </IconButton>
        </Tooltip>

        <Tooltip title="Zoom Out">
          <IconButton onClick={handleZoomOut}>
            <ZoomOutIcon />
          </IconButton>
        </Tooltip>

        <Tooltip title="My Location">
          <IconButton onClick={handleLocationTo}>
            <MyLocationIcon />
          </IconButton>
        </Tooltip>
      </Box>
    </div>
  );
};

export default MapStyledToolbar;