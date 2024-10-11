import React, { useState, useEffect } from 'react';
import { MapContainer, TileLayer, useMap } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { Box, IconButton, Tooltip, Typography, useTheme } from '@mui/material';
import AddOutlinedIcon from '@mui/icons-material/AddOutlined';
import RemoveOutlinedIcon from '@mui/icons-material/RemoveOutlined';
import MyLocationIcon from '@mui/icons-material/MyLocation';
import { styled } from "@mui/system";
import MakerIcon from './svg/normal_u47.svg?react';
import ExtendIcon from './svg/normal_u52.svg?react';
import MeasureIcon from './svg/normal_u59.svg?react';
import InfoOutlinedIcon from '@mui/icons-material/InfoOutlined';
import LayersOutlinedIcon from '@mui/icons-material/LayersOutlined';
import NotificationsOutlinedIcon from '@mui/icons-material/NotificationsOutlined';
import ViewComfyOutlinedIcon from '@mui/icons-material/ViewComfyOutlined';

const RightToolBar = styled(Box)(({ theme }) => ({
  position: 'absolute',
  top: '30px',
  right: '10px',
  display: 'flex',
  flexDirection: 'column',
  backgroundColor: 'transparent',
  //padding: '5px',
  gap: '5px',
  //borderRadius: '8px',
  zIndex: '1001',
}));

const ToolButton = styled(IconButton)(({ theme }) => ({
  backgroundColor: 'lightblue', //theme.palette.background.default,
  borderRadius: '3px',
  '&:hover': {
    backgroundColor: theme.palette.secondary.main,
  }
}));

const ExtraButton = styled(Box)(({ theme }) => ({
  display: "flex",
  justifyContent: "center",
  alignItems: "center",
  backgroundColor: 'lightblue',
  height: '36.5625px',
  borderRadius: '5px',
  '&:hover': {
    backgroundColor: theme.palette.secondary.main,
  }
}));

const ZoomDisplayButton = () => {
  const map = useMap();
  const [zoom, setZoom] = useState(map.getZoom());
  useEffect(() => {
    const handleZoomEnd = () => {
      setZoom(map.getZoom());
    };
    map.on('zoomend', handleZoomEnd);
    return () => {
      map.off('zoomend', handleZoomEnd);
    };
  }, [map]);

  return (
    <ExtraButton>
      <Typography
        sx={{
          fontSize: "14px",
          fontWeight: "bold",
        }}
      >
        {zoom}
      </Typography>
    </ExtraButton>
  );
};
const LocationButton = () => {
  const map = useMap();
  const handleMoveToLocation = () => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        const { latitude, longitude } = position.coords;
        map.setView([latitude, longitude], map.getZoom());
      });
    } else {
      alert('Geolocation is not supported by this browser.');
    }
  };
  return (
    <Tooltip title="My Location">
      <ToolButton
        sx={{
          mt: '150px'
        }}
        onClick={handleMoveToLocation}
      >
        <MyLocationIcon />
      </ToolButton>
    </Tooltip>
  );
};

const MapStyledToolbar = () => {
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const [map, setMap] = useState(null);
  const theme = useTheme();
  const handleZoomIn = () => {
    map.zoomIn();
  }
  const handleZoomOut = () => {
    map.zoomOut();
  }

  return (
    <div style={{ position: 'relative', height: '100vh' }}>
      <MapContainer
        center={center}
        zoomControl={false}
        zoom={9}
        style={{ height: '100%', width: '100%' }}
        ref={setMap}
      >
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          attribution="&copy; OpenStreetMap contributors"
        />
        <RightToolBar>
          <ToolButton>
            <NotificationsOutlinedIcon />
          </ToolButton>
          <ToolButton>
            <InfoOutlinedIcon />
          </ToolButton>

          <ToolButton
            sx={{
              mt: '25px'
            }}
          >
            <MakerIcon />
          </ToolButton>
          <ToolButton>
            <LayersOutlinedIcon />
          </ToolButton>
          <ToolButton>
            <ViewComfyOutlinedIcon />
          </ToolButton>

          <ToolButton
            sx={{
              mt: '25px'
            }}
          >
            <MeasureIcon />
          </ToolButton>

          <ToolButton
            sx={{
              mt: '25px'
            }}
          >
            <ExtendIcon />
          </ToolButton>
          <ExtraButton>
            <Typography
              sx={{
                fontSize: "14px",
                fontWeight: "bold",
              }}
            >
              XY
            </Typography>
          </ExtraButton>
          <ToolButton onClick={handleZoomIn}>
            <AddOutlinedIcon />
          </ToolButton>
          <ZoomDisplayButton />
          <ToolButton onClick={handleZoomOut}>
            <RemoveOutlinedIcon />
          </ToolButton>
          <LocationButton />
        </RightToolBar>
      </MapContainer>
    </div>
  );
};

export default MapStyledToolbar;