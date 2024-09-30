import { ListItemButton } from "@mui/material";
import { styled } from "@mui/system";

const StyledListItemButton = styled(ListItemButton)(({ theme, selected }) => ({
  height: "10vh",
  borderRadius: "20px 0 0 20px", // top-left top-right bottom-right bottom-left.
  color: selected ? theme.palette.primary[600] : theme.palette.primary.light, //theme.palette.secondary[500],
  "&::before": {
    content: '""',
    position: "absolute",
    right: "0",
    top: "-50px",
    width: "50px",
    height: "50px",
    backgroundColor: "transparent",
    borderRadius: "50%",
    pointerEvents: "none",    
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
    pointerEvents: "none",
  },
  "&:hover, &.Mui-selected:hover": {
    color: theme.palette.secondary[200],
    backgroundColor: theme.palette.secondary.main,
    zIndex: "1",
    "& .MuiListItemIcon-root": {
      color: theme.palette.secondary[200],
    },
    "&::before": {
      boxShadow: `35px 35px 0 10px ${theme.palette.secondary.main}`,
    },
    "&::after": {
      boxShadow: `35px -35px 0 10px ${theme.palette.secondary.main}`,
    },
    '&:active:before, &:active:after, &:focus:before, &:focus:after': {
      zIndex: "-1"
    },          
  },
  "&.Mui-selected": {
    backgroundColor: theme.palette.background.default,
    color: theme.palette.secondary[200],
    "& .MuiListItemIcon-root": {
      color: theme.palette.secondary[200],
    },
    "&::before": {
      boxShadow: `35px 35px 0 10px ${theme.palette.background.default}`,
    },
    "&::after": {
      boxShadow: `35px -35px 0 10px ${theme.palette.background.default}`,
    },
  },
  flexDirection: "column",
  "& .MuiListItemIcon-root": {
    justifyContent: "center",
    alignItems: "center",
  },
}));
export default StyledListItemButton;
