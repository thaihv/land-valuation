import React, { useState } from "react";
import { Box } from "@mui/material";
import { useSelector } from "react-redux";
import LeftBar from "../../../components/toolbars/LeftBar";
import ValuationMap from "../../../components/map/ValuationMap";
import Sidebar from "../../../components/Sidebar";

const BaseMap = () => {
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);
  const data = useSelector((state) => state.global.user);

  return (
    <Box display="flex" width="100%" height="100%">
      <Sidebar
        user={data || {}}
        isNonMobile="true"
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
            <ValuationMap />
          </Box>
        </Box>
      </Box>
    </Box>
  );
};

export default BaseMap;
