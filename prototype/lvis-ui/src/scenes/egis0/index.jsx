import React from "react";
import Header from "../../components/Header";
import {
  Box,
  useTheme,
  useMediaQuery,
} from "@mui/material";
import CrudDemo from "./CrudDemo"
import Map from "../../components/map/Map"
import { singlePostData } from "../../data/mockMapData";
import UserService from "../../state/UserService";

const Egis0 = () => {
  const theme = useTheme();
  const isNonMediumScreens = useMediaQuery("(min-width: 1200px)");
  console.log(UserService.getTokenParsed());
  return (
    <Box m="1.5rem 2.5rem">
      <Header title="EGIS MONITORING SYSTEM" subtitle="See real time info detected from EGIS System" />
      <Box
        mt="20px"
        display="grid"
        gridTemplateColumns="repeat(12, 1fr)"
        gridAutoRows="160px"
        gap="20px"
        sx={{
          "& > div": { gridColumn: isNonMediumScreens ? undefined : "span 12" },
        }}
      >
        <Box
          gridColumn="span 6"
          gridRow="span 3"
        >
          <Map items={[singlePostData]} />  
        </Box>
        <Box
          gridColumn="span 6"
          gridRow="span 3"
          backgroundColor={theme.palette.background.alt}
          borderRadius="5px"
        >
          <CrudDemo/>       
        </Box>
      </Box>
    </Box>
  );
};

export default Egis0;
