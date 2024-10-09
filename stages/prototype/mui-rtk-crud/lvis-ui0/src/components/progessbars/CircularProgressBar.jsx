import { Typography, Box } from "@mui/material";
import CircularProgress from "@mui/material/CircularProgress";
import PropTypes from "prop-types";

function DeterminateCircularProgress(props) {
  return (
    <Box sx={{ position: "relative" }}>
      <CircularProgress
        variant="determinate"
        sx={(theme) => ({
          color: theme.palette.secondary.main,
          ...theme.applyStyles("dark", {
            color: theme.palette.grey[800],
          }),
        })}
        size={40}
        thickness={4}
        {...props}
        value={100}
      />
    </Box>
  );
}
function CircularProgressBar(props) {
  return (
    <Box sx={{ position: "relative", display: "inline-flex" }}>
      <DeterminateCircularProgress variant="determinate" {...props} />
      <Box
        sx={{
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          position: "absolute",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <Typography
          variant="caption"
          component="div"
          sx={{ color: "text.secondary" }}
        >
          {`${Math.round(props.value)}%`}
        </Typography>
      </Box>
    </Box>
  );
}

CircularProgressBar.propTypes = {
  value: PropTypes.number.isRequired,
};
export default CircularProgressBar;
