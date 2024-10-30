import {Box} from "@mui/material";
import CircularProgress, {
  circularProgressClasses,
} from "@mui/material/CircularProgress";

function IndeterminateCircularBar(props) {
  return (
    <Box sx={{ position: "relative" }}>
      <CircularProgress
        variant="indeterminate"
        disableShrink
        sx={(theme) => ({
          color: theme.palette.secondary.main,
          animationDuration: "550ms",
          position: "absolute",
          left: 0,
          [`& .${circularProgressClasses.circle}`]: {
            strokeLinecap: "round",
          },
          ...theme.applyStyles("dark", {
            color: "#308fe8",
          }),
        })}
        size={40}
        thickness={4}
        {...props}
      />
    </Box>
  );
}
export default IndeterminateCircularBar;
