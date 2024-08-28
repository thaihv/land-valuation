import React from "react";
import { useTranslation } from "react-i18next";
import {
  FormControl,
  Select,
  MenuItem,
  InputLabel,
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
    <FlexBetween m="1rem 2rem 2.25rem 0.5rem">
      <FormControl sx={{ minWidth: 120 }}  >
      <InputLabel id="language-type">
        <Typography
          variant="h4"
          gutterBottom
          sx={{ fontWeight: "bold", color: theme.palette.secondary.main }}
          component={"span"}
        >
          Language
        </Typography>
      </InputLabel>
        <Select
          label="Select"
          value={i18n.language}
          onChange={handleLanguageChange}
        >
          <MenuItem value="en">English</MenuItem>
          <MenuItem value="ko">한국인</MenuItem>
          <MenuItem value="lo">ພາສາລາວ</MenuItem>
        </Select>
      </FormControl>
    </FlexBetween>
  );
};

export default LanguageSwitcher;
