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
  Button,
  InputAdornment,
  FormHelperText,
} from "@mui/material";
import ChevronRightIcon from "@mui/icons-material/ChevronRight";
import ChevronLeftIcon from "@mui/icons-material/ChevronLeft";
import { Search } from "@mui/icons-material";
import { useTheme } from "@mui/material";
import { useTranslation } from "react-i18next";

export default function LeftBar() {
  const theme = useTheme();
  const { t } = useTranslation();
  const [isExpanded, setExpanded] = useState(true);
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
            sx={{ height: "40px", bgcolor: "#f2f2f2" }}
          >
            <Toolbar variant="dense" sx={{ justifyContent: "center" }}>
              <Typography
                variant="h6"
                gutterBottom
                sx={{ fontWeight: "bold", color: "#333333" }}
                component={"span"}
              >
                {t("Land Value Assessment Table")}
              </Typography>
            </Toolbar>
          </AppBar>
          <Stack direction="column" spacing={2} m="1.5rem 1.5rem 1rem 1rem">
            <Box direction="row" justifyContent="space-between">
              <FormControl variant="standard" sx={{ minWidth: 130 }}>
                <InputLabel id="property-type">Property Type</InputLabel>
                <Select
                  labelId="property-type"
                  id="property"
                  label="Property Type"
                  value={propertyType}
                  onChange={handlePropertyTypeChange}
                >
                  <MenuItem value="Parcel">Parcel</MenuItem>
                  <MenuItem value="Building">Building</MenuItem>
                  <MenuItem value="Building Unit">Building Unit</MenuItem>
                  <MenuItem value="Parcel & Building Unit">
                    Parcel & Building Unit
                  </MenuItem>
                </Select>
              </FormControl>
              <FormControl variant="standard" sx={{ minWidth: 130 }}>
                <InputLabel id="order">Order By</InputLabel>
                <Select
                  labelId="order"
                  id="order"
                  label="Order By"
                  value={order}
                  onChange={handleOrderChange}
                >
                  <MenuItem value="Parcel Number">Parcel Number</MenuItem>
                  <MenuItem value="Address">Address</MenuItem>
                  <MenuItem value="Owner Name">Owner Name</MenuItem>
                  <MenuItem value="Street Name">Street Name</MenuItem>
                </Select>
              </FormControl>
              <FormControl variant="standard" sx={{ minWidth: 130 }}>
                <InputLabel id="baunit-type">City</InputLabel>
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
              <FormControl variant="standard" sx={{ minWidth: 130 }}>
                <InputLabel id="time-type">Month</InputLabel>
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
              label="Search..."
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
              <Button
                sx={{
                  backgroundColor: "#f2f2f2",
                  color: "#333333",
                  fontSize: "12px",
                  fontWeight: "bold",
                  padding: "10px 20px",
                  borderRadius: "25px",
                }}
                variant="contained"
                size="small"
              >
                {t("Search")}
              </Button>
            </Box>
          </Stack>
        </div>
      </div>
      <Box sx={{ position: "absolute", top: "50%", right: "-15px" }}>
        <Stack
          className="interactive-button"
          sx={{
            bgcolor: theme.palette.background.alt,
            "&:hover": {
              bgcolor: theme.palette.secondary.main,
            },
          }}
        >
          <IconButton
            disableRipple
            sx={{
              height: "60px",
              width: "5px",
              color: theme.palette.greenAccent.main,
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
