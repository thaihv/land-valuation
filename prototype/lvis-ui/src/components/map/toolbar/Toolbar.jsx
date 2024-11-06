import React, { useState, useEffect } from 'react';
import { useMap } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { Box, Paper, IconButton, Tooltip, FormControlLabel, Switch, Divider, Checkbox, Typography } from '@mui/material';
import AddOutlinedIcon from '@mui/icons-material/AddOutlined';
import RemoveOutlinedIcon from '@mui/icons-material/RemoveOutlined';
import MyLocationIcon from '@mui/icons-material/MyLocation';
import { styled } from "@mui/system";
import MakerIcon from '../icon/normal_u47.svg?react';
import ExtendIcon from '../icon/normal_u52.svg?react';
import MeasureIcon from '../icon/normal_u59.svg?react';
import BboxIcon from '../icon/bbox_u66.svg?react';

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

import FlexBetween from "../../FlexBetween";
import './Toolbar.css';


const ToolButton = styled(IconButton)(({ theme }) => ({
  display: "flex",
  justifyContent: "center",
  alignItems: "center",
  backgroundColor: 'lightblue',
  height: '40px',
  width: '40px',
  borderRadius: '3px',
  '&:hover': {
    backgroundColor: theme.palette.secondary.main,
  }
}));

const ExtraButton = styled(Box)(({ theme }) => ({
  display: "flex",
  justifyContent: "center",
  alignItems: "center",
  height: '40px',
  width: '40px',
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

const ExtendControl = ({ extent }) => {
  const map = useMap();

  const zoomToBounds = () => {
    map.fitBounds(extent); // Zoom the map to the defined bounds
  };
  const widthDiffInDegree = () => {
    const bounds = map.getBounds(); // Get the current map bounds
    const southWest = bounds.getSouthWest(); // Bottom-left corner (lat, lon)
    const northEast = bounds.getNorthEast(); // Top-right corner (lat, lon)
    // 1. Longitude difference (Width in degrees)
    const widthInDegrees = northEast.lng - southWest.lng;
    return widthInDegrees;
  }
  // Function to move the map left
  const moveLeft = () => {
    const currentCenter = map.getCenter();
    const diff = widthDiffInDegree();
    map.setView([currentCenter.lat, currentCenter.lng - diff], map.getZoom());
  };

  // Function to move the map right
  const moveRight = () => {
    const currentCenter = map.getCenter();
    const diff = widthDiffInDegree();
    map.setView([currentCenter.lat, currentCenter.lng + diff], map.getZoom());
  };
  return (
    <FlexBetween gap="1px">
      <ToolButton onClick={moveLeft}>
        <ArrowBackIosNewOutlinedIcon />
      </ToolButton>
      <ToolButton onClick={moveRight}>
        <ArrowForwardIosOutlinedIcon />
      </ToolButton>
      <ToolButton>
        <ZoomInOutlinedIcon />
      </ToolButton>
      <ToolButton>
        <ZoomOutOutlinedIcon />
      </ToolButton>
      <ToolButton onClick={zoomToBounds}>
        <CropFreeOutlinedIcon />
      </ToolButton>
    </FlexBetween>
  );
};
const LayerControl = ({ baseLayers, overlays, onBaseLayerChange, onOverlayToggle }) => {
  return (
    <Paper sx={{ backgroundColor: 'lightblue' }} className="tool-popover">
      <Box
        sx={{
          display: 'flex',
          flexDirection: 'column',
          whiteSpace: 'nowrap',   // Ensure the text does not wrap
          width: 'auto',          // Make width automatically adjust to content
          m: '1rem 1rem 1rem 1rem'
        }}
      >
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
      </Box>
      <Divider sx={{ m: "0 0.5rem 1rem 0.5rem" }} />
      <Box
        display="flex"
        flexDirection="column"
        m="1rem 1rem 1rem 1rem"
      >
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
      </Box>
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
const Toolbar = ({ baseLayers, overlays, onBaseLayerChange, onOverlayToggle, extent }) => {
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
        const isExtendControl = tool.name === 'Extend' ? true : false;
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
            {openToolIndex === index && !isLayerControl && !isExtendControl && implement && content && (
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
            {openToolIndex === index && isExtendControl && (
              <Paper sx={{ backgroundColor: 'transparent' }} className="tool-popover">
                <ExtendControl extent={extent} />
              </Paper>
            )}
          </div>
        )
      })}
    </div>
  );
};
export default Toolbar;