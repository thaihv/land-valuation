import { useCollapse } from "react-collapsed";
import { IconButton, Tooltip, Stack } from "@mui/material";
import ExpandLessIcon from "@mui/icons-material/ExpandLess";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import "./bottomstyle.css";
import { useTheme } from "@mui/material";

export default function BottomBar({
  handleZoomIn,
  handleZoomOut,
  handleFindLocation,
}) {
  const { getCollapseProps, getToggleProps, isExpanded } = useCollapse();
  const theme = useTheme();
  return (
    <div
      className="collapsible"
      style={{
        display: "flex",
        flexDirection: "column",
        position: "absolute",
        left: "50%",
        bottom: "0.25rem",
        zIndex: "drawer",
        transform: "translateX(-50%)",
        background: "white",
      }}
    >
      <Stack
        sx={{
          bgcolor: theme.palette.blueAccent.light,
          display: "flex",
          flexDirection: "row",
        }}
      >
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Zoom In" arrow placement="top">
            <IconButton disableRipple onClick={handleZoomIn}>
              <img src="zoomin.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Zoom Out" arrow placement="top">
            <IconButton disableRipple onClick={handleZoomOut}>
              <img src="zoomout.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Find Your Location" arrow placement="top">
            <IconButton disableRipple onClick={handleFindLocation}>
              <img src="yourLocation.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Download" arrow placement="top">
            <IconButton disableRipple>
              <img src="download.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Print" arrow placement="top">
            <IconButton disableRipple>
              <img src="print.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Base Map" arrow placement="top">
            <IconButton disableRipple>
              <img src="earth.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Layers/Legends" arrow placement="top">
            <IconButton disableRipple>
              <img src="layers.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Measure Area" arrow placement="top">
            <IconButton disableRipple>
              <img src="polygon.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <Tooltip title="Measure Distance" arrow placement="top">
            <IconButton disableRipple>
              <img src="ruler.svg" />
            </IconButton>
          </Tooltip>
        </Stack>
        <Stack
          sx={{
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <IconButton
            disableRipple
            sx={{ color: "white" }}
            className="header"
            {...getToggleProps()}
          >
            {isExpanded ? <ExpandMoreIcon /> : <ExpandLessIcon />}
          </IconButton>
        </Stack>
      </Stack>
      <div {...getCollapseProps()}>
        <div
          className="content-bottom"
          style={{
            background: theme.palette.background.alt,
            overflow: "auto",
            height: "400px",
          }}
        ></div>
      </div>
    </div>
  );
}
