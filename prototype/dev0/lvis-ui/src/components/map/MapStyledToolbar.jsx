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
const LayerControl = ({ baseLayers, overlays, onBaseLayerChange, onOverlayToggle }) => {
  return (
    <Paper sx={{ backgroundColor: 'lightblue' }} className="tool-popover">
      <div>
        <h4>Base Layers</h4>
        {baseLayers.map((layer) => (
          <FormControlLabel
            key={layer.name}
            control={
              <Switch
                checked={layer.active}
                onChange={() => onBaseLayerChange(layer.name)}
              />
            }
            label={layer.name}
          />
        ))}
      </div>
      <div>
        <h4>Overlay Layers</h4>
        {overlays.map((layer) => (
          <FormControlLabel
            key={layer.name}
            control={
              <Checkbox
                checked={layer.visible}
                onChange={() => onOverlayToggle(layer.name)}
              />
            }
            label={layer.name}
          />
        ))}
      </div>
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
const Toolbar = ({ baseLayers, overlays, onBaseLayerChange, onOverlayToggle }) => {
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
              <LayerControl
                baseLayers={baseLayers}
                overlays={overlays}
                onBaseLayerChange={onBaseLayerChange}
                onOverlayToggle={onOverlayToggle}
              />
            )}
          </div>
        )
      })}
    </div>
  );
};
const StyledGridLayer = () => {
  const map = useMap();
  useEffect(() => {
    const StyledGrid = L.GridLayer.extend({
      createTile: function (coords) {
        var tile = L.DomUtil.create("canvas", "leaflet-tile");
        var ctx = tile.getContext("2d");
        var size = this.getTileSize();
        tile.width = size.x;
        tile.height = size.y;
        // calculate projection coordinates of top left tile pixel
        var nwPoint = coords.scaleBy(size);
        // calculate geographic coordinates of top left tile pixel
        var nw = map.unproject(nwPoint, coords.z);
        ctx.fillStyle = "white";
        ctx.fillRect(0, 0, size.x, 50);
        ctx.fillStyle = "black";
        ctx.fillText(
          "x: " + coords.x + ", y: " + coords.y + ", zoom: " + coords.z,
          20,
          20
        );
        ctx.fillText("lat: " + nw.lat + ", lon: " + nw.lng, 20, 40);
        ctx.strokeStyle = "red";
        ctx.beginPath();
        ctx.moveTo(0, 0);
        ctx.lineTo(size.x - 1, 0);
        ctx.lineTo(size.x - 1, size.y - 1);
        ctx.lineTo(0, size.y - 1);
        ctx.closePath();
        ctx.stroke();
        return tile;
      }
    });

    const StyledGridLayer = new StyledGrid({
      transparent: true,
      opacity: 0.8,
      zIndex: 6,
      attribution: "Map data: © Generated by Lao Land Valuation Team",
    });
    StyledGridLayer.addTo(map);

    return () => {
      map.removeLayer(StyledGridLayer); // Clean up the layer when the component unmounts
    };
  }, [map]);

  return null;
};
const WatermarkControl = ({ theme, imgUrl, text }) => {
  const map = useMap();
  useEffect(() => {
    const Watermark = L.Control.extend({
      onAdd: () => {
        const div = L.DomUtil.create('div', 'leaflet-watermark');
        if (imgUrl) {
          const img = document.createElement('img');
          img.src = imgUrl;
          img.style.width  = '40px'; // Adjust as needed
          div.appendChild(img);
        }
        if (text) {
          const watermarkText = document.createElement('div');
          watermarkText.innerHTML = text;
          watermarkText.style.fontSize = '12px';
          watermarkText.style.color = theme.palette.background.default;
          watermarkText.style.fontWeight = 'bold';
          watermarkText.style.backgroundColor = 'transparent';
          watermarkText.style.padding = '1px 0px 0px 0px';
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
const MapStyledToolbar = () => {
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const [map, setMap] = useState(null);
  const theme = useTheme();
  const [baseLayers, setBaseLayers] = useState([
    { name: 'OpenStreetMap', active: true },
    { name: 'OpenTopoMap', active: false },
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
  const [overlays, setOverlays] = useState([
    { name: 'Province', visible: true },
    { name: 'District', visible: true },
    { name: 'Village', visible: false },
    { name: 'Road', visible: false },
    { name: 'Parcel', visible: false },
    { name: 'Valuation Object', visible: false },
    { name: 'Grid Cell', visible: false },
  ]);
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
        center={center}
        zoomControl={false}
        zoom={9}
        style={{ height: '100%', width: '100%' }}
        ref={setMap}
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
        {/* Ovarlay Layers */}
        <LayerGroup>
          {overlays[0].visible && (
            <WMSTileLayer
              layers={"lvis:province"}
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
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
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
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
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
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
              url={import.meta.env.VITE_GEOMAP_WMS_URL}
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
          {overlays[6].visible && (
            <StyledGridLayer />
          )}
        </LayerGroup>
        <Toolbar
          baseLayers={baseLayers}
          overlays={overlays}
          onBaseLayerChange={handleBaseLayerChange}
          onOverlayToggle={handleOverlayToggle}
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

export default MapStyledToolbar;