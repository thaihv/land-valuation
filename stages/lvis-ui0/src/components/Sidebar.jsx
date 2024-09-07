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
              boxSixing: "border-box",
              width: drawerWidth,
            },
          }}
        >
          <Typography component={"span"}>
            <Box width="100%">
              <Box
                onClick={() => {navigate(`/`);}}
                sx={{
                  borderRadius: "10%",
                  color: theme.palette.background.alt,
                  transition: "all 0.3s ease-in-out",
                  "&:hover": {
                    color:theme.palette.secondary[100],
                    bgcolor: theme.palette.secondary.main,
                    //transform: "perspective(75rem) rotateY(45deg)",
                  },
                }}
              >
                <FlexBetween>
                  <Box 
                      m="2.25rem 2rem 2.25rem 1.5rem"
                      display="flex" 
                      alignItems="center"                       
                  >
                    <Typography variant="h5" fontWeight= "bold">
                      LVIS
                    </Typography>
                  </Box>
                </FlexBetween>
              </Box>
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
                        sx={{ 
                          borderRadius: "10%", 
                          height: "10vh",
                          mb: "1px",
                          transition: "all 0.3s ease-in-out",                        
                          backgroundColor:
                            active === ref
                              ? theme.palette.background.default
                              : "transparent",
                          color:
                            active === ref
                              ? theme.palette.secondary[300]
                              : theme.palette.background.alt,
                          "&:hover": {
                            color: theme.palette.greenAccent.main,
                            bgcolor: theme.palette.secondary.main,
                            transform: "scale3d(1.05, 1.05, 1.05)",
                            "& .MuiListItemIcon-root": {
                              color: theme.palette.greenAccent.main,
                            }
                          },
                          flexDirection: 'column',
                        }}
                      >
                        <ListItemIcon
                          sx={{
                            ml: "2rem",
                            color:
                              active === ref
                                ? theme.palette.secondary[300]
                                : theme.palette.background.alt,
                          }}
                        >
                          {icon}
                        </ListItemIcon>
                        <ListItemText>
                          <Box textAlign="center">
                            <Typography variant="h7">{t(text)}</Typography>
                          </Box>                            
                        </ListItemText>
                      </ListItemButton>
                    </ListItem>
                  );
                })}
              </List>
            </Box>

            <Box>
              <Divider sx={{ m: "3rem 0rem 1rem 0rem" }}/>
              <FlexBetween 
                textTransform="none" 
                gap="1rem" 
                flexDirection="column" 
                overflow="auto"
              >
                <Box
                  component="img"
                  alt="profile"
                  src={
                    user.picturePath === ""
                    ? "profile.svg"
                    : `${import.meta.env.VITE_REACT_APP_BASE_URL}/profiles/${user.picturePath}`}
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
                    sx={{ color: theme.palette.background.alt }}
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
            </Box>
          </Typography>
        </Drawer>
      )}
    </Box>
  );
};

export default Sidebar;
