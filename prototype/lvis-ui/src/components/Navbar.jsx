import React, { useState } from "react";
import {
  LightModeOutlined,
  DarkModeOutlined,
  Menu as MenuIcon,
  SettingsOutlined,
  Notifications,
  ArrowDropDownOutlined,
  Close,
} from "@mui/icons-material";
import LogoutOutlinedIcon from '@mui/icons-material/LogoutOutlined';
import FlexBetween from "./FlexBetween";
import { useDispatch } from "react-redux";
import {useNavigate } from "react-router-dom";
import { setMode } from "../state";
import UserService from "../state/UserService";
import { useTranslation } from "react-i18next";
import { navItems } from "./menu/navItems";
import {
  AppBar,
  Button,
  Box,
  Typography,
  IconButton,
  Toolbar,
  Menu,
  MenuItem,
  useTheme,
  useMediaQuery
} from "@mui/material";

const Navbar = ({ user, isSidebarOpen, setIsSidebarOpen }) => {
  const dispatch = useDispatch();
  const theme = useTheme();
  const { t } = useTranslation();
  const navigate = useNavigate();
  const [anchorEl, setAnchorEl] = useState(null);
  const isOpen = Boolean(anchorEl);
  const handleClick = (event) => setAnchorEl(event.currentTarget);
  const handleClose = () => setAnchorEl(null);
  const [isMobileMenuToggled, setIsMobileMenuToggled] = useState(false);
  const isNonMobileScreens = useMediaQuery("(min-width: 600px)");
  const handleResponsiveMenu = () => {     
      isNonMobileScreens ? setIsSidebarOpen(!isSidebarOpen) : setIsMobileMenuToggled(!isMobileMenuToggled);
  }
  return (
    <AppBar
      sx={{
        position: "static",
        background: "none",
        boxShadow: "none",
      }}
    >
      <Toolbar sx={{ justifyContent: "space-between" }}>
        {/* LEFT SIDE */}
        <FlexBetween>
          <IconButton onClick={handleResponsiveMenu}>
            <MenuIcon />
          </IconButton>
          {/* MOBILE NAV */}
          {!isNonMobileScreens && isMobileMenuToggled && (
            <Box
              position="fixed"
              left="0"
              bottom="0"
              height="100%"
              zIndex="1001"
              maxWidth="500px"
              minWidth="300px"
              backgroundColor={theme.palette.background.default}
            >
              {/* CLOSE ICON */}
              <Box display="flex" justifyContent="flex-start" p="1rem">
                <IconButton
                  onClick={() => setIsMobileMenuToggled(!isMobileMenuToggled)}
                >
                  <Close />
                </IconButton>
              </Box>
              {/* MENU ITEMS */}
              <Box
                display="flex"
                flexDirection="column"
                justifyContent= "space-between"
                alignItems= "start"
                p="1rem"
              >
                <MenuItem 
                  onClick={() => {navigate(`/`);}}
                  sx={{
                    fontFamily: "Georgia, serif",
                    fontSize: "20px",
                    fontWeight: "bold",
                  }}>
                  LVIS
                </MenuItem> 

                {navItems.map(({ text, link, icon }) => {
                  const ref = link.toLowerCase();
                  return (
                    <FlexBetween key={t(text)}>
                      <IconButton>
                        {icon}
                      </IconButton>                      
                      <MenuItem 
                        onClick={() => {
                        navigate(`/${ref}`);
                        setIsMobileMenuToggled(!isMobileMenuToggled);
                      }}>
                        {t(text)}
                      </MenuItem>                        
                    </FlexBetween>                    
                  );
                })}                
              </Box>
            </Box>
          )}
        </FlexBetween>

        {/* RIGHT SIDE */}
        <FlexBetween gap="1.5rem">
          <IconButton onClick={() => dispatch(setMode())}>
            {theme.palette.mode === "dark" ? (
              <DarkModeOutlined sx={{ fontSize: "25px" }} />
            ) : (
              <LightModeOutlined sx={{ fontSize: "25px" }} />
            )}
          </IconButton>
          <IconButton>
            <SettingsOutlined sx={{ fontSize: "25px" }} />
          </IconButton>
          <Notifications sx={{ fontSize: "25px" }} />
          <FlexBetween>
            <Button
              onClick={handleClick}
              sx={{
                display: "flex",
                justifyContent: "space-between",
                alignItems: "center",
                textTransform: "none",
                gap: "1rem",
              }}
            >
              <Box
                component="img"
                alt="profile"
                src={ 
                  user.hasOwnProperty('picture_path')
                  ? user.picture_path
                  : "profile.svg"}
                height="32px"
                width="32px"
                borderRadius="50%"
                sx={{ 
                  objectFit: "cover",
                  "&:hover": {
                    transform: "scale3d(1.25, 1.25, 1.25)",
                  }, 
                }}
              />
              <Box textAlign="left">
                <Typography
                  fontWeight="bold"
                  fontSize="0.85rem"
                  sx={{ color: theme.palette.secondary[100] }}
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
              <ArrowDropDownOutlined
                sx={{ color: theme.palette.secondary[300], fontSize: "25px" }}
              />
            </Button>
            <Menu
              anchorEl={anchorEl}
              open={isOpen}
              onClose={handleClose}
              anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
            >
              <MenuItem>
                <FlexBetween
                  onClick={() => UserService.doLogout()}
                  sx={{
                    color: "#000000",
                    fontSize: "16px",
                    fontWeight: "bold",
                    "&:hover": {
                      color: theme.palette.secondary[200],
                    },
                  }}            
                >
                  <LogoutOutlinedIcon/>
                  <Typography>                  
                    {t("Sign Out")}
                  </Typography>            
                </FlexBetween>
              </MenuItem>
            </Menu>
          </FlexBetween>
        </FlexBetween>
      </Toolbar>
    </AppBar>
  );
};

export default Navbar;
