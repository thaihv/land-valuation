import { Typography, Box, Button, useTheme } from "@mui/material";
import CustomButton from "../../components/custom/CustomButton";
import { useNavigate } from "react-router-dom";

const PageNotFound = () => {
  const navigate = useNavigate();
  const theme = useTheme();
  return (
    <Box
      width="100%"
      display="flex"
      gap="0.5rem"
      flexDirection="column"
      justifyContent="center"
      alignItems="center"
    >
      <Typography
        fontSize="18px"
        fontWeight="bold"
        color={theme.palette.neutral.main}
      >
        Land Valuation Information System [404]
      </Typography>
      <Typography
        sx={{
          color: theme.palette.neutral.medium,
          fontSize: "40px",
          fontWeight: "bold",
        }}
      >
        Page you're trying to access is not available
      </Typography>
      <CustomButton variant="outlined" onClick={() => navigate("/home")}>
        Go to Home Page
      </CustomButton>
    </Box>
  );
};

export default PageNotFound;
