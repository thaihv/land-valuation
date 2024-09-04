import { Box, Typography, useTheme } from "@mui/material";
import FlexBetween from "../../components/FlexBetween";
import WidgetWrapper from "../../components/WidgetWrapper";
import { useNavigate } from "react-router-dom";

const MenuItemWidget = ({ image, title, description, link }) => {
  const { palette } = useTheme();
  const navigate = useNavigate();
  const dark = palette.neutral.dark;
  const medium = palette.neutral.medium;

  return (
    <WidgetWrapper 
      width="260px" 
      height="355px" 
      display="flex" 
      flexDirection="column" 
      alignItems="center"
      bgcolor="#ffffff"
      opacity= "0.56"
    >
      <Box 
        sx={{
          display: "flex",
          width: "170px",
          height: "170px",
          padding: "2px 2px 2px 2px", 
          border: "1px solid #797979",  
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
      >
        <img
          width="80px"
          height="80px"
          alt="menu"
          src={image}
          onClick={() => navigate(`/${link}`)}
        />
      </Box>

      <FlexBetween>
        <Typography variant="h3" fontWeight= "bold" mt="20px" color={medium}>{title}</Typography>
      </FlexBetween>
      <Typography fontSize="14px" color={medium} m="1.5rem 0" align="center">
        {description}
      </Typography>
    </WidgetWrapper>
  );
};
export default MenuItemWidget;
