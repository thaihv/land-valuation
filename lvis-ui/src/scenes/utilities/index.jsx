import * as React from "react";
import PropTypes from "prop-types";
import Tabs from "@mui/material/Tabs";
import Tab from "@mui/material/Tab";
import Box from "@mui/material/Box";
import { Typography, useTheme, useMediaQuery } from "@mui/material";
import Header from "../../components/Header";
import Breakdown from "../charts/breakdown";
import Overview from "../charts/overview";
import Geography from "../charts/geography";
import Daily from "../charts/daily";
import Monthly from "../charts/monthly";
import UserForm from "../form/users";
import FileUpload from "../form/FileUpload";
import FlexBetween from "../../components/FlexBetween";
import { PersonAdd } from "@mui/icons-material";
import BackupOutlinedIcon from "@mui/icons-material/BackupOutlined";
import LanguageOutlinedIcon from "@mui/icons-material/LanguageOutlined";
import LanguageSwitcher from "../../components/LanguageSwitcher";
import { useTranslation } from "react-i18next";
function CustomTabPanel(props) {
  const { children, value, index, ...other } = props;

  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`simple-tabpanel-${index}`}
      aria-labelledby={`simple-tab-${index}`}
      {...other}
    >
      {value === index && <Box sx={{ pt: 3 }}>{children}</Box>}
    </div>
  );
}

CustomTabPanel.propTypes = {
  children: PropTypes.node,
  index: PropTypes.number.isRequired,
  value: PropTypes.number.isRequired,
};

function a11yProps(index) {
  return {
    id: `simple-tab-${index}`,
    "aria-controls": `simple-tabpanel-${index}`,
  };
}

const Utilities = () => {
  const theme = useTheme();
  const [value, setValue] = React.useState(0);
  const isNonMediumScreens = useMediaQuery("(min-width: 1200px)");
  const { t } = useTranslation();

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
  return (
    <Box m="1.5rem 2.5rem">
      <FlexBetween>
        <Header title="ACTIVITIES"/>
      </FlexBetween>
      <Box height="75vh">
        <Box sx={{ borderBottom: 0 }}>
          <Tabs
            value={value}
            onChange={handleChange}
            aria-label="Activity Tabs"
            sx={{
              "& .MuiTabs-indicator": {
                display: "none",
              },
              "& .MuiButtonBase-root.MuiTab-root": {
                color: theme.palette.secondary[300],
                fontWeight: "bold",
                variant:"h5",
              },
              "& .MuiTab-root.Mui-selected": {
                backgroundColor: theme.palette.secondary.main,
                color: theme.palette.background.alt,
                borderRadius: "25px",
              },
            }}
          >
            <Tab label={t("Overview")} {...a11yProps(0)} />
            <Tab label={t("Daily")} {...a11yProps(1)} />
            <Tab label={t("Monthly")} {...a11yProps(2)} />
            <Tab label={t("Geography")} {...a11yProps(3)} />
            <Tab label={t("Breakdown")} {...a11yProps(4)} />
            <Tab label={t("Form")} {...a11yProps(5)} />
            <Tab
              // icon={<LanguageOutlinedIcon />}
              // iconPosition="start"
              label={t("Language")}
              {...a11yProps(6)}
            />
          </Tabs>
        </Box>
        <CustomTabPanel value={value} index={0}>
          <Overview />
        </CustomTabPanel>
        <CustomTabPanel value={value} index={1}>
          <Daily />
        </CustomTabPanel>
        <CustomTabPanel value={value} index={2}>
          <Monthly />
        </CustomTabPanel>
        <CustomTabPanel value={value} index={3}>
          <Geography />
        </CustomTabPanel>
        <CustomTabPanel value={value} index={4}>
          <Breakdown />
        </CustomTabPanel>
        <CustomTabPanel value={value} index={5}>
          <Box
            display="grid"
            gridTemplateColumns="repeat(12, minmax(0, 1fr))"
            gridAutoRows="180px"
            gap="30px"
            sx={{
              "& > div": {
                gridColumn: isNonMediumScreens ? undefined : "span 12",
              },
            }}
          >
            <Box
              gridColumn="span 7"
              gridRow="span 3"
              backgroundColor={theme.palette.background.alt}
              border={`1px solid ${theme.palette.secondary[200]}`}
              p="1rem"
            >
              <FlexBetween sx={{ mb: "20px" }}>
                <PersonAdd
                  sx={{ color: theme.palette.secondary[300], fontSize: "26px" }}
                />
                <Typography
                  variant="h5"
                  fontWeight="bold"
                  color={theme.palette.secondary[100]}
                >
                  Add new a user
                </Typography>
              </FlexBetween>
              <UserForm />
            </Box>
            <Box
              gridColumn="span 5"
              gridRow="span 3"
              backgroundColor={theme.palette.background.alt}
              border={`1px solid ${theme.palette.secondary[200]}`}
              p="1rem"
            >
              <FlexBetween sx={{ mb: "20px" }}>
                <BackupOutlinedIcon
                  sx={{ color: theme.palette.secondary[300], fontSize: "26px" }}
                />
                <Typography
                  variant="h5"
                  fontWeight="bold"
                  color={theme.palette.secondary[100]}
                >
                  Upload your file sources
                </Typography>
              </FlexBetween>
              <FileUpload />
            </Box>
          </Box>
        </CustomTabPanel>
        <CustomTabPanel value={value} index={6}>
          <Box height="75vh" border={`1px solid ${theme.palette.secondary[200]}`}>
            <LanguageSwitcher />
          </Box>          
        </CustomTabPanel>
      </Box>
    </Box>
  );
};

export default Utilities;
