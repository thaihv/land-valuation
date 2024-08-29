import React from "react";
import {
  Box,
  Divider,
  Drawer,
  IconButton,
  List,
  ListItem,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Typography,
  useTheme,
} from "@mui/material";
import {
  ChevronLeft,
} from "@mui/icons-material";
import SearchOutlinedIcon from '@mui/icons-material/SearchOutlined';
import AirplayOutlinedIcon from '@mui/icons-material/AirplayOutlined';
import RoomOutlinedIcon from '@mui/icons-material/RoomOutlined';
import CommentOutlinedIcon from '@mui/icons-material/CommentOutlined';
import AssignmentOutlinedIcon from '@mui/icons-material/AssignmentOutlined';
import BackupTableOutlinedIcon from '@mui/icons-material/BackupTableOutlined';
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import FlexBetween from "./FlexBetween";
import profileImage from "../assets/profile.jpeg";
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
    text: "Announcement",
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
      {isSidebarOpen && (
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
                  color: theme.palette.background.alt,
                  "&:hover": {
                    color: theme.palette.greenAccent.main,
                    bgcolor: theme.palette.background.alt,
                  },
                }}>
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
                  {!isNonMobile && (
                    <IconButton onClick={() => setIsSidebarOpen(!isSidebarOpen)}>
                      <ChevronLeft />
                    </IconButton>
                  )}
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
                          backgroundColor:
                            active === ref
                              ? theme.palette.background.alt
                              : "transparent",
                          color:
                            active === ref
                              ? theme.palette.greenAccent.main
                              : theme.palette.background.alt,
                          "&:hover": {
                            color: theme.palette.greenAccent.main,
                            bgcolor: theme.palette.background.alt,
                          },
                          flexDirection: 'column',
                        }}
                      >
                        <ListItemIcon
                          sx={{
                            ml: "2rem",
                            color:
                              active === ref
                                ? theme.palette.greenAccent.main
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
              <Divider sx={{ m: "5.55rem 0rem 1rem 0rem" }}/>
              <FlexBetween textTransform="none" gap="1rem" m="2.25rem 0rem 1rem 0rem" flexDirection="column">
                <Box
                  component="img"
                  alt="profile"
                  src={profileImage}
                  height="30px"
                  width="30px"
                  borderRadius="50%"
                  sx={{ objectFit: "cover" }}
                />
                <Box textAlign="center">
                  <Typography
                    fontWeight="bold"
                    fontSize="0.7rem"
                    sx={{ color: theme.palette.background.alt }}
                  >
                    {user.name}
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
