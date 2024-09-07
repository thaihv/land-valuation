import { 
  Box, 
  AppBar, 
  Button, 
  Toolbar,   
  Menu,
  MenuItem,
  Typography,
  useMediaQuery, 
  useTheme } from "@mui/material";
import {Menu as MenuIcon, Search} from "@mui/icons-material";
import LogoutOutlinedIcon from '@mui/icons-material/LogoutOutlined';
import FlexBetween from "../../components/FlexBetween";
import LanguageSwitcher from "../../components/LanguageSwitcher";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import { useParams } from "react-router-dom";
import UserWidget from "../widgets/UserWidget";
import AdvertWidget from "../widgets/AdvertWidget";
import { useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";
import { setLogout } from "../../state";
import { useTranslation } from "react-i18next";


const Top = () => {
  const theme = useTheme();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const [anchorEl, setAnchorEl] = useState(null);
  const isOpen = Boolean(anchorEl);
  const handleClick = (event) => setAnchorEl(event.currentTarget);
  const handleClose = () => setAnchorEl(null);
  const { t } = useTranslation();
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
          <img
            width="65px"
            height="43px"
            alt="flag"
            src="../lao_flag.png" 
            sx={{ objectFit: "cover" }}         
            onClick={() => {navigate(`/`);}}
          />
        </FlexBetween>

        {/* RIGHT SIDE */}
        <FlexBetween>
          <LanguageSwitcher />
          <Button
              onClick={handleClick}
              sx={{
                display: "flex",
                justifyContent: "space-between",
                alignItems: "center",
                textTransform: "none",
                gap: "1rem",
                color: "#000000",
              }}
          >
            <MenuIcon />
          </Button>    
          <Menu
            anchorEl={anchorEl}
            open={isOpen}
            onClose={handleClose}
            anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
          >
            <MenuItem>
              <FlexBetween
                onClick={() => dispatch(setLogout())}
                sx={{
                  color: "#000000",
                  fontSize: "16px",
                  fontWeight: "bold",
                  "&:hover": {
                    color: theme.palette.greenAccent.main,
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
      </Toolbar>
    </AppBar>
  );
};

const Profile = () => {
  const [user, setUser] = useState(null);
  const { id } = useParams();
  const token = useSelector((state) => state.token);
  const isNonMobileScreens = useMediaQuery("(min-width:1000px)");

  const getUser = async () => {
    const response = await fetch(`${import.meta.env.VITE_REACT_APP_BASE_URL}/general/user/${id}`, {
      method: "GET",
      headers: { Authorization: `Bearer ${token}` },
    });
    const data = await response.json();
    setUser(data);
  };

  useEffect(() => {
    getUser();
  }, []);

  if (!user) return null;

  return (
    <Box>
      <Top /> 
      <Box
        width="100%"
        padding="2rem 6%"
        display={isNonMobileScreens ? "flex" : "block"}
        gap="2rem"
        justifyContent="center"
      >
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <UserWidget userId={id} picturePath={user.picturePath} />
        </Box>
        <Box
          flexBasis={isNonMobileScreens ? "42%" : undefined}
          mt={isNonMobileScreens ? undefined : "2rem"}
        >
          <AdvertWidget />
        </Box>
      </Box>
    </Box>
  );
};

export default Profile;
