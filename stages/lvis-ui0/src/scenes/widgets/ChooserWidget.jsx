import { Box, Typography, useTheme } from "@mui/material";
import FlexBetween from "../../components/FlexBetween";
import WidgetWrapper from "../../components/WidgetWrapper";
import { useNavigate } from "react-router-dom";

const ChooserWidget = ({ image, title, description, link, width="260px", height="355px" }) => {
  const theme = useTheme();
  const navigate = useNavigate();
  const dark = theme.palette.neutral.dark;
  const medium = theme.palette.neutral.medium;
  const ref = link.toLowerCase();
  return (
    <WidgetWrapper 
      width = {width} 
      height = {height} 
      display="flex" 
      flexDirection="column" 
      alignItems="center"
      sx={{ 
        minWidth: 260, 
        minHeight: 355,
        transition: "all 0.5s",
        "&:hover": {
          bgcolor: theme.palette.background.default,
          //transform: 'translate(0%,-2%)',
          transform: "perspective(75rem) rotateY(45deg) translate(0%,-2%)",
        }, 
      }}
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
          transition: "all 0.3s",
          "&:hover": {
            bgcolor: dark,
            boxSizing: "border-box",
            transform: 'translate(-5%,0%)',
          },
        }}
        onClick={() => navigate(`/${ref}`)}
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
            transition: "all 0.3s",
            "&:hover": {
              color: theme.palette.greenAccent.main,
              transform: 'translate(-5%,0%)',
            },
          }}
          onClick={() => navigate(`/${ref}`)}
        >
          {title}
        </Typography>
      </FlexBetween>
      <Typography
        align="center" 
        sx={{
          color: medium,
          fontSize: "14px",
          m: "0.5rem 0",          
          transition: "all 1s ease-out",
          "&:hover": {
            visibility: 'visible',
            fontWeight: 'bold',
            width: '100%',
          },
        }}      
      >
        {description}
      </Typography>
    </WidgetWrapper>
  );
};
export default ChooserWidget;
