import React, { useState, useEffect, useRef } from 'react';
import { MapContainer, TileLayer, ScaleControl, WMSTileLayer, useMap } from 'react-leaflet';
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
const LayerControl = () => {
  const map = useMap();
  const [layers, setLayers] = useState([]);
  const [selectedLayers, setSelectedLayers] = useState([]);

  // Initialize base map state to manage layer visibility
  const [osmLayer, setOsmLayer] = useState(true);
  const [topoLayer, setTopoLayer] = useState(false);

  // Base Layer references
  const osmLayerRef = useRef(
    new L.TileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: "OpenStreetMap",
    })
  );
  const topoLayerRef = useRef(
    new L.TileLayer("https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png", {
      attribution: "OpenTopoMap",
    })
  );
  // Add and remove layers based on state changes
  useEffect(() => {
    if (osmLayer) {
      map.addLayer(osmLayerRef.current);
    } else {
      map.removeLayer(osmLayerRef.current);
    }
  }, [osmLayer, map]);

  useEffect(() => {
    if (topoLayer) {
      map.addLayer(topoLayerRef.current);
    } else {
      map.removeLayer(topoLayerRef.current);
    }
  }, [topoLayer, map]);

  // Handle toggling of base layers
  const handleOsmLayerChange = (event) => {
    setOsmLayer(event.target.checked);
  };

  const handleTopoLayerChange = (event) => {
    setTopoLayer(event.target.checked);
  };

  // Initialize layers from the map
  useEffect(() => {
    const mapLayers = [];
    // Iterate over layers in the map and add them to the state
    map.eachLayer((layer) => {
      if (layer instanceof L.TileLayer || layer instanceof L.WMSTileLayer) {
        mapLayers.push({ name: layer.options.layerName || "Unnamed Layer", layer });
      }
    });
    setLayers(mapLayers);
    setSelectedLayers(mapLayers.map((l) => l.name));
  }, [map]);

  // Handle changes in layer selection
  const handleLayerChange = (event) => {
    const { value } = event.target;
    setSelectedLayers(value);

    // Add or remove layers from the map based on selection
    layers.forEach((l) => {
      if (value.includes(l.name)) {
        map.addLayer(l.layer);
      } else {
        map.removeLayer(l.layer);
      }
    });
  };

  // Keep the control synced with changes in the map's layer state
  useEffect(() => {
    const onLayerAdd = (e) => {
      const layerName = layers.find((l) => l.layer === e.layer)?.name;
      if (layerName && !selectedLayers.includes(layerName)) {
        setSelectedLayers((prevSelected) => [...prevSelected, layerName]);
      }
    };

    const onLayerRemove = (e) => {
      const layerName = layers.find((l) => l.layer === e.layer)?.name;
      if (layerName && selectedLayers.includes(layerName)) {
        setSelectedLayers((prevSelected) => prevSelected.filter((name) => name !== layerName));
      }
    };

    map.on("layeradd", onLayerAdd);
    map.on("layerremove", onLayerRemove);

    return () => {
      map.off("layeradd", onLayerAdd);
      map.off("layerremove", onLayerRemove);
    };
  }, [map, layers, selectedLayers]);


  return (
    <Box
      sx={{
        width: "190px",
        backgroundColor: 'lightblue'
      }}
    >
      <FormControl fullWidth>
        <FormControlLabel
          control={<Switch checked={osmLayer} onChange={handleOsmLayerChange} />}
          label="OSM Layer"
        />
        <FormControlLabel
          control={<Switch checked={topoLayer} onChange={handleTopoLayerChange} />}
          label="Topo Layer"
        />
        <InputLabel id="layer-select-label">Layers</InputLabel>
        <Select
          labelId="layer-select-label"
          multiple
          value={selectedLayers}
          onChange={handleLayerChange}
          renderValue={(selected) => selected.join(", ")}
        >
          {layers.map((l) => (
            <MenuItem key={l.name} value={l.name}>
              <Checkbox checked={selectedLayers.includes(l.name)} />
              <ListItemText primary={l.name} />
            </MenuItem>
          ))}
        </Select>
      </FormControl>
    </Box>
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
const Toolbar = () => {
  const [openToolIndex, setOpenToolIndex] = useState(null);

  const handleMouseEnter = (index) => {
    setOpenToolIndex(index);
  };

  const handleMouseLeave = () => {
    setOpenToolIndex(null);
  };

  const tools = [
    { name: 'Notification', content: <NotificationsOutlinedIcon />, implement: null },
    { name: 'Information', content: <InfoOutlinedIcon />, implement: null },
    { name: 'Divider', content: null, implement: null },
    { name: 'Marker', content: <MakerIcon />, implement: null },
    { name: 'Layer', content: <LayersOutlinedIcon />, implement: <LayerControl /> },
    { name: 'Spliter', content: <ViewComfyOutlinedIcon />, implement: <SplitMapControl /> },
    { name: 'Divider', content: null, implement: null },
    { name: 'Measure', content: <MeasureIcon />, implement: <MeasurementControl /> },
    { name: 'Divider', content: null, implement: null },
    { name: 'Extend', content: <ExtendIcon />, implement: <ExtendControl /> },
    { name: 'Scale', content: <AspectRatioOutlinedIcon />, implement: <ScaleTableControl /> },
    { name: 'ZoomIn', content: <ZoomInButton />, implement: null },
    { name: 'Level', content: <ZoomDisplayButton />, implement: null },
    { name: 'ZoomOut', content: <ZoomOutButton />, implement: null },
    { name: 'Divider', content: null, implement: null },
    { name: 'Location', content: <LocationButton />, implement: null },
  ];

  return (
    <div className="toolbar">
      {tools.map((tool, index) => {
        const implement = tool.implement;
        const content = tool.content;
        const lastItem = tool.name === 'Location' ? true : false;
        if (!content && !implement) { // is Divider
          return (
            <Box m="1.25vh 0 1.25vh 0" key={index}>
            </Box>
          );
        }
        return (
          <div
            key={index}
            className={`toolbar-button ${lastItem ? 'last-item':''}`}
            onMouseEnter={() => handleMouseEnter(index)}
            onMouseLeave={handleMouseLeave}
          >
            <ExtraButton >
              {tool.content}
            </ExtraButton>
            {openToolIndex === index && implement && content && (
              <Paper sx={{ backgroundColor: 'transparent' }} className="tool-popover">
                {tool.implement}
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
          attribution="OpenStreetMap"
          layerName="OpenStreetMap"
        />
        <TileLayer
          url="https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png"
          attribution="OpenTopoMap"
          layerName="OpenTopoMap"
        />
        <WMSTileLayer
          layers={"lvis:province"}
          url={import.meta.env.VITE_GEOMAP_WMS_URL}
          maxZoom={20}
          transparent={true}
          styles="province"
          format="image/png"
          opacity={0.6}
          layerName="Province"
        />
        <WMSTileLayer
          layers={"lvis:district"}
          url={import.meta.env.VITE_GEOMAP_WMS_URL}
          maxZoom={20}
          transparent={true}
          styles="district"
          format="image/png"
          opacity={0.8}
          layerName="District"
        />
        <WMSTileLayer
          layers={"lvis:village"}
          url={import.meta.env.VITE_GEOMAP_WMS_URL}
          maxZoom={20}
          transparent={true}
          styles="village"
          format="image/png"
          opacity={0.85}
          layerName="Village"
        />
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
        <WMSTileLayer
          layers={"lvis:parcel_re"}
          url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
          maxZoom={20}
          transparent={true}
          format="image/png"
          opacity={0.6}
          layerName="Parcel"
        />
        <WMSTileLayer
          layers={"lvis:parcel_tech"}
          url={import.meta.env.VITE_GEOMAP_WMS_URL_BK}
          maxZoom={20}
          transparent={true}
          styles="parcel_tech"
          tiled={true}
          format="image/png"
          opacity={0.6}
          layerName="Valuation Object"
        />
        <Toolbar />
        <ScaleControl position="bottomright" imperial={false} />
      </MapContainer>
    </div>
  );
};

export default MapStyledToolbar;