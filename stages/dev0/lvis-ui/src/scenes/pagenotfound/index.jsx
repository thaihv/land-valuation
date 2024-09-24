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
        <Grid container spacing={2}>
          <Grid xs={4}>
            <img
              src="./404.jpg"
              alt=""
              width={256} height={256}
            />
          </Grid>
          <Grid xs={8}>
            <Typography variant="h5" fontWeight="bold" color="#1E88E5">
              [LVIS] Land Valuation Information System
            </Typography>
            <Typography variant="h4">
              The page you’re looking for doesn’t exist.
            </Typography>
            <StyledButton variant="outlined" onClick={() => navigate("/home")}>
              Go to Home Page
            </StyledButton>
          </Grid>          
        </Grid>
      </Container>
    </Box>
  );
};

export default PageNotFound;
