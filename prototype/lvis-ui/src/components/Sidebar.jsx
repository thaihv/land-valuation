import React from "react";
import {
  Box,
  Divider,
  Drawer,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  Typography,
  useTheme,
  useMediaQuery
} from "@mui/material";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import FlexBetween from "./FlexBetween";
import { navItems } from "./menu/navItems";
import { useTranslation } from "react-i18next";
import StyledListItemButton from "./custom/StyledListItemButton";


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
  const isNonPortraitMode = useMediaQuery("(min-height: 600px)");

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
              backgroundImage: theme.palette.primary.gradient,
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
              <Box onClick={() => {navigate(`/`);}}>
                <FlexBetween>
                  <Box 
                      m="3.5rem 2rem 2rem 1rem"
                      display="flex" 
                      alignItems="center"                 
                  >
                    <Typography 
                      sx={{
                        display: "inline-block",
                        position: "relative",
                        fontFamily: "Georgia, serif",
                        fontSize: "20px",
                        fontWeight: "bold",
                        color: theme.palette.primary.light, //theme.palette.secondary[500],
                        "&::before": { 
                          position: "absolute",
                          display:"inline-block",
                          top: "-2.75rem",
                          left: "0.15rem",
                          content: '""',
                          background: "url(./monre.svg) left top no-repeat",
                          // Sizing needed
                          height: "45px",
                          width: "45px",
                          backgroundSize: "45px 45px",
                          zIndex: "-1"                                                    
                        },                        
                        "&::after": {
                          content: '""',
                          position: "absolute",
                          bottom: "0",
                          width: "100%",
                          height: "3px",
                          left: "0",
                          backgroundColor: theme.palette.secondary[200],
                          transform: "scaleX(0)",
                          transformOrigin: "bottom right",
                          transition: "transform 0.25s ease-out"
                        },
                        "&:hover": {
                          color: theme.palette.background.default
                        },
                        "&:hover::after": {
                          transform: "scaleX(1)",
                          transformOrigin: "bottom left",
                        },                                                   
                      }}
                    >
                      LVIS
                    </Typography>
                  </Box>
                </FlexBetween>
              </Box>
              <Divider sx={{ m: "0 0.5rem 1rem 0.5rem"}}/>
              <List>
                {navItems.map(({ text, link, icon }) => {
                  const ref = link.toLowerCase();
                  return (
                    <ListItem key={t(text)} disablePadding>
                      <StyledListItemButton
                        onClick={() => {
                          navigate(`/${ref}`);
                          setActive(ref);
                        }}      
                        selected={active === ref}                
                      >
                        <ListItemIcon
                          sx={{
                            color:
                              active === ref
                              ? theme.palette.primary[600]
                              : theme.palette.primary.light, //theme.palette.secondary[500],
                          }}
                        >
                          {icon}
                        </ListItemIcon>
                        {isNonPortraitMode && (
                          <ListItemText>
                            <Box 
                              sx={{
                                lineHeight: "15px",
                                textAlign: "center"
                              }} 
                            >
                              <Typography 
                                // variant="h7"
                                // fontFamily="Aclonica, sans-serif"
                                // fontStyle="normal"
                                // fontWeight="400"
                              >
                                {t(text)}
                              </Typography>
                            </Box>                            
                          </ListItemText>
                        )}
                      </StyledListItemButton>
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
                    : `${import.meta.env.VITE_REACT_APP_BASE_URL}/profiles/${user._id}_${user.picturePath}`}
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
