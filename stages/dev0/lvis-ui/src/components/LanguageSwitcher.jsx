import React from "react";
import { useTranslation } from "react-i18next";
import {
  FormControl,
  Select,
  MenuItem,
  InputBase,
  Typography,
} from "@mui/material";
import { useTheme } from "@mui/material";
import FlexBetween from "./FlexBetween";
const LanguageSwitcher = () => {
  const { i18n } = useTranslation();
  const theme = useTheme();
  const handleLanguageChange = (e) => {
    const newLang = e.target.value;
    i18n.changeLanguage(newLang);
  };

  return (
    <FlexBetween>
      <FormControl variant="standard">
        <Select
          label="Select"
          value={i18n.language}
          onChange={handleLanguageChange}
          sx={{
            backgroundColor: theme.palette.background.default,
            width: "120px",
            borderRadius: "0.25rem",
            p: "0.25rem 1rem",
            "& .MuiSvgIcon-root": {
              pr: "0.25rem",
              width: "3rem",
            },
            "& .MuiSelect-select:focus": {
              backgroundColor: theme.palette.background.alt,
            },
          }}
          input={<InputBase />}
        >
          <MenuItem value="en">
            <Typography>English</Typography>
          </MenuItem>
          <MenuItem value="ko">
            <Typography>한국인</Typography>
          </MenuItem>
          <MenuItem value="lo">
            <Typography>ພາສາລາວ</Typography>
          </MenuItem>
        </Select>
      </FormControl>
    </FlexBetween>
  );
};

export default LanguageSwitcher;
