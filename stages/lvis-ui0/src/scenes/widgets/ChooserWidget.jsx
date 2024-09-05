import { Box, Typography, useTheme } from "@mui/material";
import FlexBetween from "../../components/FlexBetween";
import WidgetWrapper from "../../components/WidgetWrapper";
import { useNavigate } from "react-router-dom";

const ChooserWidget = ({ image, title, description, link, width="260px", height="355px" }) => {
  const theme = useTheme();
  const navigate = useNavigate();
  const dark = theme.palette.neutral.dark;
  const medium = theme.palette.neutral.medium;

  return (
    <WidgetWrapper 
      width = {width} 
      height = {height} 
      display="flex" 
      flexDirection="column" 
      alignItems="center"
      sx={{ minWidth: 260, minHeight: 355 }}
    >
      <Box 
        sx={{
          display: "flex",
          width: "170px",
          height: "170px", 
          opacity: "0.8",
          bgcolor: "#002868",
          borderRadius: "50%",
          justifyContent: "center",
          alignItems: "center",
          "&:hover": {
            bgcolor: dark,
            boxSizing: "border-box"
          },
        }}
        onClick={() => navigate(`/${link}`)}
      >
        <img
          width="80px"
          height="80px"
          alt="menu"
          src={image} 
          sx={{ objectFit: "cover" }}         
        />
      </Box>

      <FlexBetween>
        <Typography 
          sx={{
            color: medium,
            fontSize: "32px",
            fontWeight: "bold",
            mt: "10px",
            "&:hover": {
              color: theme.palette.greenAccent.main,
              bgcolor: theme.palette.background.alt,
            },
          }}
          onClick={() => navigate(`/${link}`)}
        >
          {title}
        </Typography>
      </FlexBetween>
      <Typography fontSize="14px" color={medium} m="0.5rem 0" align="center">
        {description}
      </Typography>
    </WidgetWrapper>
  );
};
export default ChooserWidget;
