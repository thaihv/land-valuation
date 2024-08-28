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
} from "@mui/material";
import ChevronRightIcon from "@mui/icons-material/ChevronRight";
import ChevronLeftIcon from "@mui/icons-material/ChevronLeft";
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

  function handleOnClick() {
    setExpanded(!isExpanded);
  }

  return (
    <Stack
      className="collapsible"
      sx={{
        display: "flex",
        //position: "absolute",
        position: "relative",
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
          <Typography component={"span"}>
            <Stack direction="column" spacing={2}>
              <Stack direction="row" justifyContent="space-between">
                <FormControl variant="standard" sx={{ minWidth: 130 }}>
                  <InputLabel id="property-type">Property Type:</InputLabel>
                  <Select
                    labelId="property-type"
                    id="property"
                    label="Property Type"
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
                  <InputLabel id="order">Order By:</InputLabel>
                  <Select labelId="order" id="order" label="Order By">
                    <MenuItem value="Parcel Number">Parcel Number</MenuItem>
                    <MenuItem value="Address">Address</MenuItem>
                    <MenuItem value="Owner Name">Owner Name</MenuItem>
                    <MenuItem value="Street Name">Street Name</MenuItem>
                  </Select>
                </FormControl>
              </Stack>
              <TextField label="Enter criteria..." variant="standard" />
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
          </Typography>
        </div>
      </div>
      <Box sx={{ position: "absolute", top: "50%", right: "-15px" }}>
        <Stack
          className="interactive-button"
          sx={{
            bgcolor: "#f2f2f2",
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
              color: "#333333",
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
