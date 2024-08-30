import { Box, Typography, useMediaQuery, useTheme} from "@mui/material";
import React, { useState } from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import Navbar from "../../components/Navbar";

const HomePage = () => {
  const theme = useTheme();
  const navigate = useNavigate();
  const isNonMobileScreens = useMediaQuery("(min-width:1000px)");
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);
  const data = useSelector((state) => state.global.user);
  return (
    <Box>
      <Navbar 
          user={data || {}}
          isSidebarOpen={isSidebarOpen}
          setIsSidebarOpen={setIsSidebarOpen}
      /> 
      <Box
        width="100%"
        padding="2rem 6%"
        display={isNonMobileScreens ? "flex" : "block"}
        gap="0.5rem"
        justifyContent="space-between"
      >
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <Typography
            fontWeight="bold"
            fontSize="clamp(1rem, 2rem, 2.25rem)"
            color={theme.palette.neutral.main}
            onClick={() => navigate("/survey")}
            sx={{
              "&:hover": {
                color: theme.palette.secondary.main,
                cursor: "pointer",
              },
            }}
          >
            Survey
          </Typography>
          <Typography
            fontWeight="bold"
            fontSize="clamp(1rem, 2rem, 2.25rem)"
            color={theme.palette.neutral.main}
            onClick={() => navigate("/products")}
            sx={{
              "&:hover": {
                color: theme.palette.secondary.main,
                cursor: "pointer",
              },
            }}
          >
            Products
          </Typography>
        </Box>
      </Box>
    </Box>
  );
};

export default HomePage;
