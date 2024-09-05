import ChooserWidget from "../widgets/ChooserWidget";
import {
  AppBar,
  Box,
  Typography,
  IconButton,
  InputBase,
  Toolbar,
  useTheme,
  useMediaQuery,
} from "@mui/material";
import {
  Menu as MenuIcon,
  Search,
} from "@mui/icons-material";
import FlexBetween from "../../components/FlexBetween";
import LanguageSwitcher from "../../components/LanguageSwitcher";

const Top = () => {
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
          />
        </FlexBetween>

        {/* RIGHT SIDE */}
        <FlexBetween gap="1.5rem">
          <FlexBetween>
            <LanguageSwitcher />
            <IconButton>
                <MenuIcon />
            </IconButton>
          </FlexBetween>
        </FlexBetween>
      </Toolbar>
    </AppBar>
  );
};

const Middle = () => {
  const theme = useTheme();
  return (
    <Box
      width="100%"
      display="flex"
      gap="0.5rem"
      flexDirection="column" 
      alignItems="center"
    >
      <Typography fontSize="18px" fontWeight="bold" color={theme.palette.neutral.medium}>          
        LVIS(Land Value Information System)
      </Typography>     
      <Typography 
            sx={{
              color: theme.palette.neutral.medium,
              fontSize: "72px",
              fontWeight: "bold",
            }} 
          >            
            지가정보시스템
      </Typography>      
      <FlexBetween
          backgroundColor={theme.palette.background.alt}
          borderRadius="30px"
          gap="3rem"
          p="0.1rem 1.5rem"
          width="620px" 
          height="50px"
          border="1px solid"
          color="#999999"
        >
        <InputBase       
          fullWidth 
          placeholder="검색어(지역명, 마을명, 코드 등)을 입력해주세요." />
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
          mt: "5rem",
        }}     
      >
      </Box>
    </Box>
  );
};

const HomePage = () => {
  const isNonMobileScreens = useMediaQuery("(min-width:1000px)");
  return (
    <Box>
      <Top /> 
      <Middle />
      <Box
        width="100%"
        padding="1rem 6%"
        display={isNonMobileScreens ? "flex" : "block"}
        gap="0.5rem"
        justifyContent="space-between"
      >
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <ChooserWidget 
            image="u29.png" 
            title="지가 조회" 
            description="지역별 토지 가격 정보를 손쉽게 조회합니다" 
            link="Products"
          />
        </Box>
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <ChooserWidget 
            image="u25.png" 
            title="지가 업무 관리" 
            description="지가산정을 위한 다양한 업무 자료 관리를 지원합니다" 
            link="Transactions"
          />
        </Box>
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <ChooserWidget 
            image="u26.png" 
            title="지가 산정" 
            description="지역별 토지 비교가격을 평가 및 분석하여 산정합니다" 
            link="Survey"
          />
        </Box>                
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <ChooserWidget 
            image="u27.png" 
            title="통계정보" 
            description="사용자 관리, 권한 관리 등 시스템 운영에 필요한 내용을 관리합니다" 
            link="Dashboard"
          />
        </Box>  
        <Box flexBasis={isNonMobileScreens ? "26%" : undefined}>
          <ChooserWidget 
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
