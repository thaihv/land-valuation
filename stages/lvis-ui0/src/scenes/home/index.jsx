import React, { useState } from "react";
import {
  AppBar,
  Box,
  Button,
  Menu,
  MenuItem,
  Typography,
  IconButton,
  InputBase,
  Toolbar,
  useTheme,
} from "@mui/material";
import {Menu as MenuIcon, Search} from "@mui/icons-material";
import LogoutOutlinedIcon from '@mui/icons-material/LogoutOutlined';
import FlexBetween from "../../components/FlexBetween";
import LanguageSwitcher from "../../components/LanguageSwitcher";
import ChooserWidget from "../widgets/ChooserWidget";
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
            src="lao_flag.png" 
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

const Middle = () => {
  const theme = useTheme();
  const { t } = useTranslation();  
  return (
    <Box
      width="100%"
      display="flex"
      gap="0.5rem"
      flexDirection="column" 
      alignItems="center"
    >
      <Box 
        display="flex" 
        flexDirection="column"
        alignItems="flex-start"
        sx={{
          "& .MuiTypography-root ": {
            lineHeight: '1.25',           
          },
        }} 
      >
        <Typography fontSize="18px" fontWeight="bold" color={theme.palette.neutral.medium}>          
          LVIS(Land Valuation Information System)
        </Typography>     
        <Typography 
              sx={{
                color: theme.palette.neutral.medium,
                fontSize: "72px",
                fontWeight: "bold",
              }} 
            >            
              {t("Land Value Information System")}
        </Typography>
      </Box>      
      <FlexBetween
          backgroundColor={theme.palette.background.alt}
          borderRadius="30px"
          gap="3rem"
          p="0.1rem 1.5rem"
          width="38%" 
          height="50px"
          border="1px solid #999999"
          mt="3rem"
        >
        <InputBase       
          fullWidth 
          placeholder={t("Please enter a search term (region name, town name, code, etc.).")} />
        <IconButton>
          <Search />
        </IconButton>
      </FlexBetween>
      <Box
        sx={{
          width: "100%",
          height: "21px",
          padding: "2px 2px 2px 2px", 
          bgcolor: "#002868",
          opacity: "0.5",
          mt: "3rem",
        }}     
      >
      </Box>
    </Box>
  );
};

const HomePage = () => {
  const { t } = useTranslation();
  return (
    <Box>
      <Top /> 
      <Middle />
      {/* MENU CHOOSER */}
      <Box
        width="100%"
        padding="1rem 6%"
        display="flex"
        flexWrap= 'wrap'
        gap="0.5rem"
        justifyContent='center'
        alignItems='center'
      >
        <Box>
          <ChooserWidget 
            image="u29.png" 
            title={t("Land Value Inquiry")}
            description={t("Check easily land value information by region")}
            link="Search"
          />
        </Box>
        <Box>
          <ChooserWidget 
            image="u25.png" 
            title={t("Manage Valuation Business")} 
            description={t("Support to manage various businesses of land valuation process")} 
            link="Transactions"
          />
        </Box>
        <Box>
          <ChooserWidget 
            image="u26.png" 
            title={t("Land Valuation")}
            description={t("Calculate, analyze and compare land value by region")} 
            link="Products"
          />
        </Box>                
        <Box>
          <ChooserWidget 
            image="u27.png" 
            title={t("Statistical Information")} 
            description={t("Provides visualized and statistical analysis based on land value")}  
            link="Dashboard"
          />
        </Box>  
        <Box>
          <ChooserWidget 
            image="u28.png" 
            title={t("System Administration")}
            description={t("Manages requirements for operation, such as user and permission")} 
            link="Survey"
          />
        </Box>                  
      </Box>
    </Box>
  );
};

export default HomePage;
