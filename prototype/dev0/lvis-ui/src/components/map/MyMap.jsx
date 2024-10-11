import React, { useState } from 'react';
import { MapContainer, TileLayer } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { Button, Paper, Typography } from '@mui/material';
import './MyMap.css';

const Toolbar = () => {
  const [openToolIndex, setOpenToolIndex] = useState(null);

  const handleMouseEnter = (index) => {
    setOpenToolIndex(index);
  };

  const handleMouseLeave = () => {
    setOpenToolIndex(null);
  };

  const tools = [
    { name: 'Tool 1', content: 'This is Tool 1' },
    { name: 'Tool 2', content: 'This is Tool 2' },
    { name: 'Tool 3', content: 'This is Tool 3' },
  ];

  return (
    <div className="toolbar">
      {tools.map((tool, index) => (
        <div
          key={index}
          className="toolbar-button"
          onMouseEnter={() => handleMouseEnter(index)}
          onMouseLeave={handleMouseLeave}
        >
          <Button variant="contained" color="primary">
            {tool.name}
          </Button>

          {openToolIndex === index && (
            <Paper className="tool-popover">
              <Typography>{tool.content}</Typography>
            </Paper>
          )}
        </div>
      ))}
    </div>
  );
};

const MyMap = () => {
  return (
    <MapContainer center={[51.505, -0.09]} zoom={13} style={{ height: '100vh', width: '100%' }}>
      <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
      <Toolbar />
    </MapContainer>
  );
};

export default MyMap;