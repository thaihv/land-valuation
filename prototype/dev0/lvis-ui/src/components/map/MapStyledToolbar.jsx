import React, { useState, useEffect } from 'react';
import { MapContainer, TileLayer, useMap } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { Box, Paper, IconButton, Tooltip, Typography, useTheme } from '@mui/material';
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
import './MapStyledToolbar.css';


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
      <ToolButton onClick={handleMoveToLocation}>
        <MyLocationIcon />
      </ToolButton>
    </Tooltip>
  );
};


const ZoomInButton = () => {
  const map = useMap();
  const handleZoomIn = () => {
    map.zoomIn();
  }
  return (
    <ToolButton onClick={handleZoomIn}>
      <AddOutlinedIcon />
    </ToolButton>
  );
};
const ZoomOutButton = () => {
  const map = useMap();
  const handleZoomOut = () => {
    map.zoomOut();
  }
  return (
    <ToolButton onClick={handleZoomOut}>
      <RemoveOutlinedIcon />
    </ToolButton>
  );
};
const Toolbar = () => {
  const [openToolIndex, setOpenToolIndex] = useState(null);

  const handleMouseEnter = (index) => {
    setOpenToolIndex(index);
  };

  const handleMouseLeave = () => {
    setOpenToolIndex(null);
  };

  const tools = [
    { name: 'Notification', content: 'Notification', icon: <NotificationsOutlinedIcon /> },
    { name: 'Information', content: 'Information', icon: <InfoOutlinedIcon /> },
    { name: 'Divider', content: null, icon: null },
    { name: 'Marker', content: 'Search', icon: <MakerIcon /> },
    { name: 'Layer', content: 'Layers', icon: <LayersOutlinedIcon /> },
    { name: 'Spliter', content: 'Divide up screen', icon: <ViewComfyOutlinedIcon /> },
    { name: 'Divider', content: null, icon: null },
    { name: 'Measure', content: 'Measurement', icon: <MeasureIcon /> },
    { name: 'Divider', content: null, icon: null },
    { name: 'Extend', content: 'Extend', icon: <ExtendIcon /> },
    { name: 'Scale', content: 'XY', icon: null },
    { name: 'ZoomIn', content: <ZoomInButton />, icon: null },
    { name: 'Level', content: <ZoomDisplayButton />, icon: null },
    { name: 'ZoomOut', content: <ZoomOutButton />, icon: null },
    { name: 'Divider', content: null, icon: null },
    { name: 'Location', content: <LocationButton />, icon: null },
  ];

  return (
    <div className="toolbar">
      {tools.map((tool, index) => {
        const icon = tool.icon;
        const content = tool.content;
        if (!icon && !content) { // is Divider
          return (
            <Box mt="10px" key={index}>
            </Box>
          );
        }
        return (
          <div
            key={index}
            className="toolbar-button"
            onMouseEnter={() => handleMouseEnter(index)}
            onMouseLeave={handleMouseLeave}
          >
            {icon && (
              <IconButton>
                {tool.icon}
              </IconButton>)
            }
            {!icon && (
              <ExtraButton>
                {tool.content}
              </ExtraButton>
            )}

            {openToolIndex === index && (
              <Paper className="tool-popover">
                <Typography>I am here</Typography>
              </Paper>
            )}
          </div>
        )
      })}
    </div>
  );
};


const MapStyledToolbar = () => {
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const [map, setMap] = useState(null);
  const theme = useTheme();

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
        <Toolbar />
      </MapContainer>
    </div>
  );
};

export default MapStyledToolbar;