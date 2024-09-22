import { Typography, Box, Container, useTheme } from "@mui/material";
import Grid from '@mui/material/Grid2';
import CustomButton from "../../components/custom/CustomButton";
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
            <Typography variant="h1">
              404
            </Typography>
            <Typography variant="h5">
              The page you’re looking for doesn’t exist.
            </Typography>
            <CustomButton variant="outlined" onClick={() => navigate("/home")}>
              Go to Home Page
            </CustomButton>
          </Grid>          
        </Grid>
      </Container>
    </Box>
  );
};

export default PageNotFound;
