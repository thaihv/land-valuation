import { useState } from "react";
import { useCollapse } from "react-collapsed";
import {
  IconButton,
  Box,
  Typography,
  Stack,
  AppBar,
  Toolbar,
  FormControl,
  Select,
  InputLabel,
  MenuItem,
  TextField,
  InputAdornment,
  FormHelperText,
} from "@mui/material";
import StyledButton from "../custom/StyledButton"
import ChevronRightIcon from "@mui/icons-material/ChevronRight";
import ChevronLeftIcon from "@mui/icons-material/ChevronLeft";
import { Search } from "@mui/icons-material";
import { useTheme } from "@mui/material";
import { useTranslation } from "react-i18next";

export default function LeftBar() {
  const theme = useTheme();
  const { t } = useTranslation();
  const [isExpanded, setExpanded] = useState(false);
  const { getCollapseProps, getToggleProps } = useCollapse({
    isExpanded,
    hasDisabledAnimation: true,
  });

  const [searchInput, setSearchInput] = useState("");
  const [propertyType, setPropertyType] = useState("Parcel");
  const [order, setOrder] = useState("Parcel Number");
  const [baunitType, setBAUnitType] = useState("Vientiane");
  const [month, setMonth] = useState("February");

  const handlePropertyTypeChange = (event) => {
    setPropertyType(event.target.value);
  };
  const handleOrderChange = (event) => {
    setOrder(event.target.value);
  };
  const handleBAUnitTypeChange = (event) => {
    setBAUnitType(event.target.value);
  };
  const handleMonthChange = (event) => {
    setMonth(event.target.value);
  };
  function handleOnClick() {
    setExpanded(!isExpanded);
  }
  return (
    <Stack
      className="collapsible"
      sx={{
        display: "flex",
        position: "absolute",
        justifyContent: "flex-start",
        height: "100vh",
        zIndex: "drawer",
      }}
    >
      <div {...getCollapseProps()}>
        <div
          style={{
            height: "100vh",
            background: theme.palette.background.alt,
          }}
        >
          <AppBar
            position="relative"
            sx={{ height: "40px", bgcolor: theme.palette.background.default }}
          >
            <Toolbar variant="dense" sx={{ justifyContent: "center" }}>
              <Typography
                variant="h6"
                gutterBottom
                sx={{ fontWeight: "bold", color: theme.palette.neutral.main }}
                component={"span"}
              >
                {t("Land Value Assessment Table")}
              </Typography>
            </Toolbar>
          </AppBar>
          <Stack direction="column" spacing={2} m="1.5rem 1.5rem 1rem 1rem">
            <Box direction="row" justifyContent="space-between">
              <FormControl variant="standard">
                <InputLabel id="property-type">{t("Property Type")}</InputLabel>
                <Select
                  labelId="property-type"
                  id="property"
                  label="Property Type"
                  value={propertyType}
                  onChange={handlePropertyTypeChange}
                >
                  <MenuItem value="Parcel">{t("Parcel")}</MenuItem>
                  <MenuItem value="Building">{t("Building")}</MenuItem>
                  <MenuItem value="Building Unit">{t("Building Unit")}</MenuItem>
                  <MenuItem value="Parcel & Building Unit">{t("Parcel & Building Unit")}</MenuItem>
                </Select>
              </FormControl>
              <FormControl variant="standard">
                <InputLabel id="order">{t("Order By")}</InputLabel>
                <Select
                  labelId="order"
                  id="order"
                  label="Order By"
                  value={order}
                  onChange={handleOrderChange}
                >
                  <MenuItem value="Parcel Number">{t("Parcel Number")}</MenuItem>
                  <MenuItem value="Address">{t("Address")}</MenuItem>
                  <MenuItem value="Owner Name">{t("Owner Name")}</MenuItem>
                  <MenuItem value="Street Name">{t("Street Name")}</MenuItem>
                </Select>
              </FormControl>
              <FormControl variant="standard">
                <InputLabel id="baunit-type">{t("City")}</InputLabel>
                <Select
                  labelId="baunit"
                  id="baunit"
                  label="City"
                  value={baunitType}
                  onChange={handleBAUnitTypeChange}
                >
                  <MenuItem value="Vientiane">Vientiane</MenuItem>
                  <MenuItem value="Phonsavan">Phonsavan</MenuItem>
                  <MenuItem value="Savannakhet">Savannakhet</MenuItem>
                </Select>
              </FormControl>
              <FormControl variant="standard">
                <InputLabel id="time-type">{t("Month")}</InputLabel>
                <Select
                  labelId="time-type"
                  id="month"
                  label="Month"
                  value={month}
                  onChange={handleMonthChange}
                >
                  <MenuItem value="January">January</MenuItem>
                  <MenuItem value="February">February</MenuItem>
                  <MenuItem value="March">March</MenuItem>
                  <MenuItem value="April">April</MenuItem>
                  <MenuItem value="May">May</MenuItem>
                  <MenuItem value="June">June</MenuItem>
                  <MenuItem value="July">July</MenuItem>
                  <MenuItem value="August">August</MenuItem>
                  <MenuItem value="September">September</MenuItem>
                  <MenuItem value="October">October</MenuItem>
                  <MenuItem value="November">November</MenuItem>
                  <MenuItem value="December">December</MenuItem>
                </Select>
              </FormControl>
            </Box>
            <TextField
              label={t("Search...")}
              onChange={(e) => setSearchInput(e.target.value)}
              value={searchInput}
              sx={{ mb: "0.5rem" }}
              variant="standard"
              InputProps={{
                endAdornment: (
                  <InputAdornment position="end">
                    <IconButton
                      onClick={() => {
                        console.log(searchInput);
                        setSearchInput("");
                      }}
                    >
                      <Search />
                    </IconButton>
                  </InputAdornment>
                ),
              }}
            />
            <FormHelperText>Select criteria to filter</FormHelperText>
            <Box sx={{ display: "flex", justifyContent: "center" }}>
              <StyledButton
                variant="contained"
                size="small"
              >
                {t("Search")}
              </StyledButton>
            </Box>
          </Stack>
        </div>
      </div>
      <Box sx={{ position: "absolute", top: "50%", right: "-12px" }}>
        <Stack
          className="interactive-button"
          sx={{
            borderRadius: "0 5px 5px 0", // top-left top-right bottom-right bottom-left.
            bgcolor: theme.palette.background.default,
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <IconButton
            disableRipple
            sx={{
              height: "80px",
              width: "12px", 
              padding: "0px", //width + padding => right postition above            
              color: theme.palette.secondary[200],
            }}
            {...getToggleProps({ onClick: handleOnClick })}
          >
            {isExpanded ? <ChevronLeftIcon /> : <ChevronRightIcon />}
          </IconButton>
        </Stack>
      </Box>
    </Stack>
  );
}
