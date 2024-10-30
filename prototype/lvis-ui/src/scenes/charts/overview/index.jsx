import React, { useState } from "react";
import { FormControl, MenuItem, InputLabel, Box, Select, useTheme } from "@mui/material";
import OverviewChart from "../../../components/OverviewChart";

const Overview = () => {
  const theme = useTheme();
  const [view, setView] = useState("units");

  return (
    <Box height="70vh" borderRadius="4px" border={`1px solid ${theme.palette.secondary[200]}`}>
      <FormControl sx={{ mt: "1rem", ml: "0.5rem" }}>
        <InputLabel>View</InputLabel>
        <Select
          value={view}
          label="View"
          onChange={(e) => setView(e.target.value)}
        >
          <MenuItem value="sales">Sales</MenuItem>
          <MenuItem value="units">Units</MenuItem>
        </Select>
      </FormControl>
      <OverviewChart view={view} />
    </Box>
  );
};

export default Overview;
