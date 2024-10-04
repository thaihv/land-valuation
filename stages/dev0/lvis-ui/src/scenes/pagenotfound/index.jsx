import { Typography, Box, Container, useTheme } from "@mui/material";
import Grid from '@mui/material/Grid2';
import StyledButton from "../../components/custom/StyledButton";
import { useNavigate } from "react-router-dom";

const PageNotFound = () => {
  const navigate = useNavigate();
  const theme = useTheme();
  return (

    <Box
      sx={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        minHeight: '100vh'
      }}
    >
      <Container maxWidth="md">
        <Grid container spacing={5}>
          <Grid xs={4}>
            <img
              src="./404.png"
              alt=""
              width={368} height={155}
            />
          </Grid>
          <Grid xs={8}>
            <Typography variant="h4" fontWeight="bold">
              Land Valuation Information System
            </Typography>
            <Typography sx={{mt: "5px"}} variant="h5" color={theme.palette.redAccent[400]}> 
              The page you’re looking for doesn’t exist.
            </Typography>
            <StyledButton sx={{mt: "50px", border: `2px solid ${theme.palette.neutral.dark}`}} variant="outlined" onClick={() => navigate("/home")}>
              Go to Home Page
            </StyledButton>
          </Grid>          
        </Grid>
      </Container>
    </Box>
  );
};

export default PageNotFound;
