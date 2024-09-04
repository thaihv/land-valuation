import { Box, Typography, useMediaQuery, useTheme} from "@mui/material";
import React, { useState } from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import Navbar from "../../components/Navbar";
import MenuItemWidget from "../widgets/MenuItemWidget";

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
          <MenuItemWidget 
            image="u29.png" 
            title="지가 조회" 
            description="지역별 토지 가격 정보를 손쉽게 조회합니다" 
            link="Products"
          />
        </Box>
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <MenuItemWidget 
            image="u25.png" 
            title="지가 업무 관리" 
            description="지가산정을 위한 다양한 업무 자료 관리를 지원합니다" 
            link="Transactions"
          />
        </Box>
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <MenuItemWidget 
            image="u26.png" 
            title="지가 산정" 
            description="지역별 토지 비교가격을 평가 및 분석하여 산정합니다" 
            link="Survey"
          />
        </Box>                
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <MenuItemWidget 
            image="u27.png" 
            title="통계정보" 
            description="사용자 관리, 권한 관리 등 시스템 운영에 필요한 내용을 관리합니다" 
            link="Dashboard"
          />
        </Box>  
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <MenuItemWidget 
            image="u28.png" 
            title="시스템 관리" 
            description="사용자 관리, 권한 관리 등 시스템 운영에 필요한 내용을 관리합니다" 
            link="MyTeam"
          />
        </Box>                  
      </Box>
    </Box>
  );
};

export default HomePage;
