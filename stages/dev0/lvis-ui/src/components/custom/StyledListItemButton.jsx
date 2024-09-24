import { ListItemButton } from "@mui/material";
import { styled } from "@mui/system";


const StyledListItemButton = styled(ListItemButton)(({ theme, selected }) => ({     
  height: "10vh",
  borderRadius: "20px 0 0 20px", // top-left top-right bottom-right bottom-left.
  color:
    selected
      ? theme.palette.secondary[200]
      : "white",                              
  "&:hover, &.Mui-selected, &.Mui-selected:hover": {
    color: theme.palette.secondary[200],
    backgroundColor: theme.palette.secondary.main,
    "& .MuiListItemIcon-root": {
      color: theme.palette.secondary[200],                                
    },
    "&::before": {
      content: '""',
      position: "absolute",
      right: "0",
      top: "-50px",
      width: "50px",
      height: "50px",
      backgroundColor: "transparent",
      borderRadius: "50%",
      boxShadow: `35px 35px 0 10px ${theme.palette.secondary.main}`,
      pointerEvents: "none"
    },
    "&::after": {
      content: '""',
      position: "absolute",
      right: "0",
      bottom: "-50px",
      width: "50px",
      height: "50px",
      backgroundColor: "transparent",
      borderRadius: "50%",
      boxShadow: `35px -35px 0 10px ${theme.palette.secondary.main}`,
      pointerEvents: "none"
    },                                                                                                                      
  },
  "&:hover": {
    "&::after": {
      zIndex: "1000",
    }, 
  },         
  "&.Mui-selected": {
    backgroundColor: theme.palette.background.default,
    "&::before": {                           
      boxShadow: `35px 35px 0 10px ${theme.palette.background.default}`,
    },
    "&::after": {
      boxShadow: `35px -35px 0 10px ${theme.palette.background.default}`,
    }, 
  },                                                                                                                 
  flexDirection: 'column'
}));
export default StyledListItemButton;