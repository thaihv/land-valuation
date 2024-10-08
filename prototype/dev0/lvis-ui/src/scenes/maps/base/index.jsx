import React from "react";
import { Box, useTheme } from "@mui/material";
import Header from "../../../components/Header";
import Map from "../../../components/map/Map";
import MapStyledToolbar from "../../../components/map/MapStyledToolbar";
import { singlePostData } from "../../../data/mockMapData";

const BaseMap = () => {
  const theme = useTheme();

  return (
    <Box m="1.5rem 2.5rem">
      <Header title="SEARCH VALUES" subtitle="Find price of your properties." />
      <Box
        mt="40px"
        height="75vh"
        border={`1px solid ${theme.palette.secondary[200]}`}
        borderRadius="4px"
      >
        {/* <Map items={[singlePostData]} /> */}
        <MapStyledToolbar/>
      </Box>
    </Box>
  );
};

export default BaseMap;
