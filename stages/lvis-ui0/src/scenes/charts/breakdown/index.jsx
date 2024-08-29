import React from "react";
import { Box, useTheme } from "@mui/material";
import BreakdownChart from "../../../components/BreakdownChart";

const Breakdown = () => {
  const theme = useTheme();
  return (
    <Box height="75vh" border={`1px solid ${theme.palette.secondary[200]}`}>
      <BreakdownChart />
    </Box>
  );
};

export default Breakdown;
