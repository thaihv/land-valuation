import React, { useState, useEffect, useRef } from 'react';
import { MapContainer, TileLayer, ScaleControl, WMSTileLayer, LayerGroup, useMap } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { Box, Paper, IconButton, Tooltip, FormControlLabel, Switch, FormControl, Select, InputLabel, Checkbox, MenuItem, ListItemText, Typography, useTheme } from '@mui/material';
import AddOutlinedIcon from '@mui/icons-material/AddOutlined';
import RemoveOutlinedIcon from '@mui/icons-material/RemoveOutlined';
import MyLocationIcon from '@mui/icons-material/MyLocation';
import { styled } from "@mui/system";
import MakerIcon from './svg/normal_u47.svg?react';
import ExtendIcon from './svg/normal_u52.svg?react';
import MeasureIcon from './svg/normal_u59.svg?react';
import BboxIcon from './svg/bbox_u66.svg?react';

import InfoOutlinedIcon from '@mui/icons-material/InfoOutlined';
import LayersOutlinedIcon from '@mui/icons-material/LayersOutlined';
import NotificationsOutlinedIcon from '@mui/icons-material/NotificationsOutlined';
import ViewComfyOutlinedIcon from '@mui/icons-material/ViewComfyOutlined';
import AspectRatioOutlinedIcon from '@mui/icons-material/AspectRatioOutlined';

import ArrowBackIosNewOutlinedIcon from '@mui/icons-material/ArrowBackIosNewOutlined';
import ArrowForwardIosOutlinedIcon from '@mui/icons-material/ArrowForwardIosOutlined';
import ZoomInOutlinedIcon from '@mui/icons-material/ZoomInOutlined';
import ZoomOutOutlinedIcon from '@mui/icons-material/ZoomOutOutlined';
import CropFreeOutlinedIcon from '@mui/icons-material/CropFreeOutlined';

import FlexBetween from "../FlexBetween";
import './MapStyledToolbar.css';


const ToolButton = styled(IconButton)(({ theme }) => ({
  display: "flex",
  justifyContent: "center",
  alignItems: "center",
  backgroundColor: 'lightblue',
  height: '5vh',  //40px instead
  width: '2.5vw', //40px instead
  borderRadius: '3px',
  '&:hover': {
    backgroundColor: theme.palette.secondary.main,
  }
}));

const ExtraButton = styled(Box)(({ theme }) => ({
  display: "flex",
  justifyContent: "center",
  alignItems: "center",
  height: '5vh', //40px instead
  width: '2.5vw', //40px instead
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

const ExtendControl = () => {
  return (
    <FlexBetween gap="1px">
      <ToolButton onClick={() => console.log('Back')}>
        <ArrowBackIosNewOutlinedIcon />
      </ToolButton>
      <ToolButton onClick={() => console.log('Forward')}>
        <ArrowForwardIosOutlinedIcon />
      </ToolButton>
      <ToolButton onClick={() => console.log('ZoomIn')}>
        <ZoomInOutlinedIcon />
      </ToolButton>
      <ToolButton onClick={() => console.log('ZoomOut')}>
        <ZoomOutOutlinedIcon />
      </ToolButton>
      <ToolButton onClick={() => console.log('Extent')}>
        <CropFreeOutlinedIcon />
      </ToolButton>
    </FlexBetween>
  );
};
const LayerControl = ({ layers, onToggle }) => {
  return (
    <Paper sx={{ backgroundColor: 'lightblue' }} className="tool-popover">
      {layers.map((layer) => (
        <FormControlLabel
          key={layer.name}
          control={
            <Checkbox
              checked={layer.visible}
              onChange={() => onToggle(layer.name)}
            />
          }
          label={layer.name}
        />
      ))}
    </Paper>
  );
};
const ScaleTableControl = () => {
  return (
    <Typography>I am Scale</Typography>
  );
};
const SplitMapControl = () => {
  return (
    <Typography>I am Split Map</Typography>
  );
};
const MeasurementControl = () => {
  return (
    <FlexBetween gap="1px">
      <ToolButton onClick={() => console.log('Forward')}>
        <ArrowForwardIosOutlinedIcon />
      </ToolButton>
      <ToolButton onClick={() => console.log('Bbox')}>
        <BboxIcon />
      </ToolButton>
    </FlexBetween>
  );
};
const Toolbar = ({ layers, onToggle }) => {
  const [openToolIndex, setOpenToolIndex] = useState(null);

  const handleMouseEnter = (index) => {
    setOpenToolIndex(index);
  };

  const handleMouseLeave = () => {
    setOpenToolIndex(null);
  };

  const tools = [
    { name: 'Notification', content: <NotificationsOutlinedIcon />, impl: null },
    { name: 'Information', content: <InfoOutlinedIcon />, impl: null },
    { name: 'Divider', content: null, impl: null },
    { name: 'Marker', content: <MakerIcon />, impl: null },
    { name: 'Layer', content: <LayersOutlinedIcon />, impl: <LayerControl /> },
    { name: 'Spliter', content: <ViewComfyOutlinedIcon />, impl: <SplitMapControl /> },
    { name: 'Divider', content: null, impl: null },
    { name: 'Measure', content: <MeasureIcon />, impl: <MeasurementControl /> },
    { name: 'Divider', content: null, impl: null },
    { name: 'Extend', content: <ExtendIcon />, impl: <ExtendControl /> },
    { name: 'Scale', content: <AspectRatioOutlinedIcon />, impl: <ScaleTableControl /> },
    { name: 'ZoomIn', content: <ZoomInButton />, impl: null },
    { name: 'Level', content: <ZoomDisplayButton />, impl: null },
    { name: 'ZoomOut', content: <ZoomOutButton />, impl: null },
    { name: 'Divider', content: null, impl: null },
    { name: 'Location', content: <LocationButton />, impl: null },
  ];

  return (
    <div className="toolbar">
      {tools.map((tool, index) => {
        const implement = tool.impl;
        const content = tool.content;
        const lastOne = tool.name === 'Location' ? true : false;
        const isLayerControl = tool.name === 'Layer' ? true : false;

        if (!content && !implement) { // is Divider
          return (
            <Box m="1.25vh 0 1.25vh 0" key={index}>
            </Box>
          );
        }
        return (
          <div
            key={index}
            className={`toolbar-button ${lastOne ? 'last-button' : ''}`}
            onMouseEnter={() => handleMouseEnter(index)}
            onMouseLeave={handleMouseLeave}
          >
            <ExtraButton >
              {content}
            </ExtraButton>
            {openToolIndex === index && !isLayerControl && implement && content && (
              <Paper sx={{ backgroundColor: 'transparent' }} className="tool-popover">
                {implement}
              </Paper>
            )}
            {openToolIndex === index && isLayerControl && (
              <LayerControl layers={layers} onToggle={onToggle} />
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
  const [layers, setLayers] = useState([
    { name: 'OpenStreetMap', visible: true, type: 'BaseMap' },
    { name: 'OpenTopoMap', visible: false, type: 'BaseMap' },
    { name: 'Province', visible: true, type: 'Overlay' },
    { name: 'District', visible: true, type: 'Overlay' },
    { name: 'Village', visible: false, type: 'Overlay' },
    { name: 'Road', visible: true, type: 'Overlay' },
    { name: 'Parcel', visible: false, type: 'Overlay' },
    { name: 'Valuation Object', visible: false, type: 'Overlay' },
  ]);
  const handleToggle = (layerName) => {
    setLayers((prev) =>
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
        center={center}
        zoomControl={false}
        zoom={9}
        style={{ height: '100%', width: '100%' }}
        ref={setMap}
      >
        {/* Base Layers */}
        {layers[0].visible && (
          <TileLayer
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            attribution="OpenStreetMap"
          />
        )}
        {layers[1].visible && (
          <TileLayer
            url="https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png"
            attribution="OpenTopoMap"
          />
        )}
        {/* Additional Layers */}
        <LayerGroup>
          {layers[2].visible && (
            <WMSTileLayer
              layers={"lvis:province"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
              maxZoom={20}
              transparent={true}
              styles="province"
              format="image/png"
              opacity={0.6}
            />
          )}
          {layers[3].visible && (
            <WMSTileLayer
              layers={"lvis:district"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
              maxZoom={20}
              transparent={true}
              styles="district"
              format="image/png"
              opacity={0.8}
            />
          )}
          {layers[4].visible && (
            <WMSTileLayer
              layers={"lvis:village"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
              maxZoom={20}
              transparent={true}
              styles="village"
              format="image/png"
              opacity={0.85}
            />
          )}
          {layers[5].visible && (
            <WMSTileLayer
              layers={"lvis:road"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
              maxZoom={20}
              transparent={true}
              styles="road"
              format="image/png"
              opacity={1}
              layerName="Road"
            />
          )}
          {layers[6].visible && (          
            <WMSTileLayer
              layers={"lvis:parcel_re"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
              maxZoom={20}
              transparent={true}
              format="image/png"
              opacity={0.6}
            />
          )}
          {layers[7].visible && (          
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
          )}                    
        </LayerGroup>
        <Toolbar layers={layers} onToggle={handleToggle} />
        <ScaleControl position="bottomright" imperial={false} />
      </MapContainer>
    </div>
  );
};

export default MapStyledToolbar;