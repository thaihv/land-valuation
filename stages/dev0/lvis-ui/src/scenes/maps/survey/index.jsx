import React, { useState } from "react";
import { Box, useMediaQuery } from "@mui/material";
import { useSelector } from "react-redux";
import LeftBar from "../../../components/toolbars/LeftBar";
import LeafletMap from "../../../components/map/LeafletMap";
import Sidebar from "../../../components/Sidebar";

const SurveyMap = () => {
  const isNonMobile = useMediaQuery("(min-width: 600px)");
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);
  const data = useSelector((state) => state.global.user);

  return (
    <Box display={isNonMobile ? "flex" : "block"} width="100%" height="100%">
      <Sidebar
        user={data || {}}
        isNonMobile={isNonMobile}
        drawerWidth="88px"
        isSidebarOpen={isSidebarOpen}
        setIsSidebarOpen={setIsSidebarOpen}
      />
      <Box flexGrow={1}>
        <Box
          height="100vh"
          position= "relative"
          sx={{
            display: "grid",
            gridTemplateColumns: "repeat(4, 1fr)",
            gap: 0,
            gridTemplateRows: "repeat(2, 1fr)",
            gridTemplateAreas: `"left map map map"
            "left map map map"`,
          }}
        >
          <Box sx={{ gridArea: "left" }}>
            <LeftBar />
          </Box>
          <Box sx={{ gridArea: "1/1/3/5" }}>
            <LeafletMap />
          </Box>
        </Box>
      </Box>
    </Box>
  );
};

export default SurveyMap;
