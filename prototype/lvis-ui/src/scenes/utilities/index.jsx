import PropTypes from "prop-types";
import {
  Typography,
  Tabs,
  Tab,
  Box,
  useTheme,
  useMediaQuery,
} from "@mui/material";
import Header from "../../components/Header";
import Breakdown from "../charts/breakdown";
import Overview from "../charts/overview";
import Geography from "../charts/geography";
import Daily from "../charts/daily";
import Monthly from "../charts/monthly";
import FileUpload from "../form/FileUpload";
import FileDownloader from "../form/FileDownload";
import FlexBetween from "../../components/FlexBetween";
import UploadFileOutlinedIcon from "@mui/icons-material/UploadFileOutlined";
import DownloadForOfflineOutlinedIcon from "@mui/icons-material/DownloadForOfflineOutlined";
import LanguageSwitcher from "../../components/LanguageSwitcher";
import { useTranslation } from "react-i18next";
import { useState } from "react";

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
  const [value, setValue] = useState(0);
  const isNonMediumScreens = useMediaQuery("(min-width: 1000px)");
  const { t } = useTranslation();

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
  return (
    <Box m="1.5rem 2.5rem">
      <FlexBetween>
        <Header title="ACTIVITIES" />
      </FlexBetween>
      <Box
          //mt="20px"
          display="grid"
          gridTemplateColumns="repeat(12, minmax(0, 1fr))"
          justifyContent="space-between"
          rowGap="20px"
          columnGap="1.33%"
          sx={{
            "& > div": { gridColumn: "span 12" },
          }}      
      >
        <Box sx={{ borderBottom: 0 }}>
          <Tabs
            variant={!isNonMediumScreens ? "scrollable" : "standard"}
            scrollButtons
            allowScrollButtonsMobile
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
                variant: "h5",
              },
              "& .MuiTab-root.Mui-selected": {
                backgroundColor: theme.palette.background.alt,
                //backgroundImage: theme.palette.primary.gradient,
                borderRadius: "15px",
              },
            }}
          >
            <Tab label={t("Overview")} {...a11yProps(0)} />
            <Tab label={t("Daily")} {...a11yProps(1)} />
            <Tab label={t("Monthly")} {...a11yProps(2)} />
            <Tab label={t("Geography")} {...a11yProps(3)} />
            <Tab label={t("Breakdown")} {...a11yProps(4)} />
            <Tab label={t("Upload")} {...a11yProps(5)} />
            <Tab label={t("Language")} {...a11yProps(6)} />
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
            gap="30px"
            sx={{
              "& > div": {
                gridColumn: isNonMediumScreens ? undefined : "span 12",
              },
            }}
          >
            <Box
              gridColumn="span 4"
              gridRow="span 2"
              backgroundColor={theme.palette.background.alt}
              border={`1px solid ${theme.palette.secondary[200]}`}
              p="1rem"
            >
              <FlexBetween sx={{ mb: "20px" }}>
                <UploadFileOutlinedIcon
                  sx={{ color: theme.palette.secondary[300], fontSize: "26px" }}
                />
                <Typography
                  variant="h5"
                  fontWeight="bold"
                  color={theme.palette.secondary[100]}
                >
                  Uploader
                </Typography>
              </FlexBetween>
              <FileUpload />
            </Box>
            <Box
              gridColumn="span 8"
              gridRow="span 2"
              backgroundColor={theme.palette.background.alt}
              border={`1px solid ${theme.palette.secondary[200]}`}
              p="1rem"
            >
              <FlexBetween sx={{ mb: "20px" }}>
                <DownloadForOfflineOutlinedIcon
                  sx={{ color: theme.palette.secondary[300], fontSize: "26px" }}
                />
                <Typography
                  variant="h5"
                  fontWeight="bold"
                  color={theme.palette.secondary[100]}
                >
                  Downloader
                </Typography>
              </FlexBetween>
              <FileDownloader />
            </Box>
          </Box>
        </CustomTabPanel>
        <CustomTabPanel value={value} index={6}>
          <Box
            height="70vh"
            borderRadius= "4px"
            border={`1px solid ${theme.palette.secondary[200]}`}
          >
            <LanguageSwitcher />
          </Box>
        </CustomTabPanel>
      </Box>
    </Box>
  );
};

export default Utilities;
