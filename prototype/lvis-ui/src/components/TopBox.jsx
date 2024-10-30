import { 
  AppBar, 
  Button, 
  Toolbar,   
  Menu,
  MenuItem,
  Typography,
  useTheme } from "@mui/material";
import {Menu as MenuIcon} from "@mui/icons-material";
import LogoutOutlinedIcon from '@mui/icons-material/LogoutOutlined';
import FlexBetween from "./FlexBetween";
import LanguageSwitcher from "./LanguageSwitcher";
import { useState } from "react";
import { useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";
import UserService from "../state/UserService";
import { useTranslation } from "react-i18next";


const TopBox = () => {
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
      </Toolbar>
    </AppBar>
  );
};

export default TopBox;

