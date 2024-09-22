import React from "react";
import {
  Box,
  Divider,
  Drawer,
  List,
  ListItem,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Typography,
  useTheme,
} from "@mui/material";
import SearchOutlinedIcon from '@mui/icons-material/SearchOutlined';
import AirplayOutlinedIcon from '@mui/icons-material/AirplayOutlined';
import RoomOutlinedIcon from '@mui/icons-material/RoomOutlined';
import CommentOutlinedIcon from '@mui/icons-material/CommentOutlined';
import AssignmentOutlinedIcon from '@mui/icons-material/AssignmentOutlined';
import BackupTableOutlinedIcon from '@mui/icons-material/BackupTableOutlined';
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import FlexBetween from "./FlexBetween";
import { useTranslation } from "react-i18next";

const navItems = [
  {
    text: "Search",
    link: "Search",
    icon: <SearchOutlinedIcon />,
  },
  {
    text: "Preparation",
    link: "Myteam",
    icon: <AirplayOutlinedIcon/>,
  },
  {
    text: "Data Collection",
    link: "Products",
    icon: <RoomOutlinedIcon />,
  },  
  {
    text: "Assessment Activity",
    link: "Survey",
    icon: <CommentOutlinedIcon />,
  },
  {
    text: "Approval",
    link: "Transactions",
    icon: <AssignmentOutlinedIcon />,
  },  
  {
    text: "Publish",
    link: "Tasks",
    icon: <BackupTableOutlinedIcon />,
  },
];

const Sidebar = ({
  user,
  drawerWidth,
  isSidebarOpen,
  setIsSidebarOpen,
  isNonMobile,
}) => {
  const { pathname } = useLocation();
  const [active, setActive] = useState("");
  const navigate = useNavigate();
  const { t } = useTranslation();
  const theme = useTheme();

  useEffect(() => {
    setActive(pathname.substring(1));
  }, [pathname]);

  return (
    <Box component="nav">
      {isSidebarOpen && isNonMobile && (
        <Drawer
          open={isSidebarOpen}
          onClose={() => setIsSidebarOpen(false)}
          variant="persistent"
          anchor="left"
          sx={{            
            width: drawerWidth,            
            "& .MuiDrawer-paper": {
              color: theme.palette.background.alt,
              backgroundImage: "linear-gradient(-183.41658819177138deg, #002868 14.848712496895075%, #002868 70.24578650224022%)",
              //borderLeft: "5px solid #2a2185",
              borderLeft: "0",              
              borderRight: "0",
              borderRadius: "20px 0 0 20px", // top-left top-right bottom-right bottom-left.
              transition: "0.5s",
              overflow: "hidden",              
              width: drawerWidth,
            },
          }}
        >
          <Typography component={"span"}>
            <Box width="100%">
              <Box
                onClick={() => {navigate(`/`);}}
                sx={{
                  color: theme.palette.greenAccent.main,
                  transition: "all 0.3s ease-in-out",
                  "&:hover": {
                    color:theme.palette.secondary[200],
                    bgcolor: theme.palette.secondary.main,
                  },         
                }}
              >
                <FlexBetween>
                  <Box 
                      m="2.25rem 2rem 2.25rem 1.5rem"
                      display="flex" 
                      alignItems="center"                 
                  >
                    <Typography 
                      //variant="h3" fontWeight= "bold" fontStyle={}
                      sx={{
                        fontFamily: "Georgia, serif",
                        fontSize: "20px",
                        fontWeight: "bold",
                        color: "white",
                      }}
                    >
                      LVIS
                    </Typography>
                  </Box>
                </FlexBetween>
              </Box>
              <Divider sx={{ m: "0 0.5rem 3rem 0.5rem"}}/>
              <List>
                {navItems.map(({ text, link, icon }) => {
                  const ref = link.toLowerCase();
                  return (
                    <ListItem key={t(text)} disablePadding>
                      <ListItemButton
                        onClick={() => {
                          navigate(`/${ref}`);
                          setActive(ref);
                        }}      
                        selected={active === ref}                
                        sx={{
                          height: "70px",
                          //m: "2px 0 2px 0",
                          borderRadius: "20px 0 0 20px", // top-left top-right bottom-right bottom-left.
                          color:
                            active === ref
                              ? theme.palette.secondary[200]
                              : "white",                              
                          "&:hover, &.Mui-selected:hover": {
                            color: theme.palette.secondary[200],
                            bgcolor: theme.palette.secondary.main,
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
                              bgcolor: "transparent",
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
                              bgcolor: "transparent",
                              borderRadius: "50%",
                              boxShadow: `35px -35px 0 10px ${theme.palette.secondary.main}`,
                              pointerEvents: "none",
                              zIndex: "1000"
                            },                                                                                                                      
                          },
                          "&.Mui-selected": {
                            backgroundColor: theme.palette.background.default,
                            "&::before": {                           
                              content: '""',
                              position: "absolute",
                              right: "0",
                              top: "-50px",
                              width: "50px",
                              height: "50px",
                              bgcolor: "transparent",
                              borderRadius: "50%",
                              boxShadow: `35px 35px 0 10px ${theme.palette.background.default}`,
                              pointerEvents: "none"
                            },
                            "&::after": {
                              content: '""',
                              position: "absolute",
                              right: "0",
                              bottom: "-50px",
                              width: "50px",
                              height: "50px",
                              bgcolor: "transparent",
                              borderRadius: "50%",
                              boxShadow: `35px -35px 0 10px ${theme.palette.background.default}`,
                              pointerEvents: "none"
                            }, 
                          },                                                                                                                 
                          flexDirection: 'column',
                        }}
                      >
                        <ListItemIcon
                          sx={{
                            ml: "2rem",
                            minWidth:"60px",
                            height: "20px",
                            fontSize: "1.75rem",
                            color:
                              active === ref
                                ? theme.palette.secondary[200]
                                : "white",
                          }}
                        >
                          {icon}
                        </ListItemIcon>
                        <ListItemText>
                          <Box 
                            sx={{
                              lineHeight: "20px",
                              textAlign: "center"
                            }} 
                          >
                            <Typography 
                              variant="h7"
                            >
                              {t(text)}
                            </Typography>
                          </Box>                            
                        </ListItemText>
                      </ListItemButton>
                    </ListItem>
                  );
                })}
              </List>
            </Box>

            {/* <Box>
              <Divider sx={{ m: "4.5rem 1rem 1rem 1rem", borderColor: theme.palette.background.alt}}/>
              <FlexBetween 
                textTransform="none"
                flexDirection="column" 
                overflow="auto"
              >
                <Box
                  component="img"
                  alt="profile"
                  src={
                    user.picturePath === ""
                    ? "profile.svg"
                    : `${import.meta.env.VITE_REACT_APP_BASE_URL}/profiles/${user.email}_${user.picturePath}`}
                  height="30px"
                  width="30px"
                  borderRadius="50%"
                  onClick={() => navigate(`/profile/${user._id}`)}
                  sx={{ 
                    objectFit: "cover",
                    "&:hover": {
                      transform: "scale3d(1.25, 1.25, 1.25)",
                    }, 
                  }}
                />
                <Box textAlign="center">
                  <Typography
                    fontWeight="bold"
                    fontSize="0.7rem"
                    sx={{ color: theme.palette.secondary[300] }}
                  >
                    {user.name}
                  </Typography>
                  <Typography
                    fontSize="0.75rem"
                    sx={{ color: theme.palette.secondary[200] }}
                  >
                    {user.occupation}
                  </Typography>                  
                </Box>
              </FlexBetween>
            </Box> */}
          </Typography>
        </Drawer>
      )}
    </Box>
  );
};

export default Sidebar;
