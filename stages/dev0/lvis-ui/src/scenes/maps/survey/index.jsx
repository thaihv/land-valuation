import { Box } from "@mui/material";
import LeftBar from "../../../components/toolbars/LeftBar";
import LeafletMap from "../../../components/map/LeafletMap";

const SurveyMap = () => {
  return (
    <Box>
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
  );
};

export default SurveyMap;
