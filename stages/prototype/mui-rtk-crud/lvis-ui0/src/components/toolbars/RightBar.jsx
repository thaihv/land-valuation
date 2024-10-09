import { useCollapse } from "react-collapsed";
import { IconButton, Typography, AppBar, Toolbar, Stack } from "@mui/material";
import { useTheme } from "@mui/material";
import ChevronRightIcon from "@mui/icons-material/ChevronRight";
import ChevronLeftIcon from "@mui/icons-material/ChevronLeft";

export default function RightBar() {
  const theme = useTheme();
  const { getCollapseProps, getToggleProps, isExpanded } = useCollapse({
    hasDisabledAnimation: true,
  });
  return (
    <div
      className="collapsible"
      style={{
        display: "flex",
        flexDirection: "row",
        position: "absolute",
        top: "200px",
        right: "2.25rem",
        zIndex: "drawer",
      }}
    >
      <Stack
        sx={{
          height: "fit-content",
          position: "absolute",
          top: "40px",
          left: "-40px",
          bgcolor: theme.palette.blueAccent.light,
          "&:hover": {
            bgcolor: theme.palette.secondary.main,
          },
        }}
        className="interactive-button"
      >
        <IconButton
          disableRipple
          sx={{ color: "white" }}
          className="header"
          {...getToggleProps()}
        >
          {isExpanded ? <ChevronRightIcon /> : <ChevronLeftIcon />}
        </IconButton>
      </Stack>

      <div {...getCollapseProps()}>
        <div className="content">
          <AppBar
            position="relative"
            sx={{ height: "40px", bgcolor: theme.palette.blueAccent.light }}
          >
            <Toolbar variant="dense" sx={{ justifyContent: "center" }}>
              <Typography
                variant="h6"
                gutterBottom
                sx={{ fontWeight: "bold", color: theme.palette.secondary.main }}
              >
                Results
              </Typography>
            </Toolbar>
          </AppBar>
          <Stack
            sx={{
              bgcolor: theme.palette.background.alt,
              overflow: "auto",
              height: "400px",
              padding: "24px",
            }}
          ></Stack>
        </div>
      </div>
    </div>
  );
}
