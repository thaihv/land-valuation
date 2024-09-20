import React from "react";
import { Box, useTheme } from "@mui/material";
import Header from "../../../components/Header";
import Map from "../../../components/map/Map";
import StaticMap from "../../../components/map/StaticMap";
import DrawMap from "../../../components/map/DrawMap";
import PolygonMap from "../../../components/map/PolygonMap";
import { singlePostData } from "../../../data/mockMapData";

const BaseMap = () => {
  const theme = useTheme();

  return (
    <Box m="1.5rem 2.5rem">
      <Header title="SURVEY VALUES FOR NEW PLAN" subtitle="Find your properties to input model information." />
      <Box
        mt="40px"
        height="75vh"
        border={`1px solid ${theme.palette.secondary[200]}`}
        borderRadius="4px"
      >
        <Map items={[singlePostData]} />
        {/* <DrawMap /> */}
        {/* <PolygonMap /> */}
      </Box>
    </Box>
  );
};

export default BaseMap;