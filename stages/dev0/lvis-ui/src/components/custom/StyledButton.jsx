import { Button } from "@mui/material";
import { styled } from "@mui/system";


const StyledButton = styled(Button)(({ theme }) => ({     
  backgroundColor: theme.palette.background.default,
  color: theme.palette.neutral.dark,
  fontSize: "12px",
  fontWeight: "bold",
  padding: "10px 20px",
  borderRadius: "15px",
  '&:hover': {
    backgroundColor: theme.palette.secondary[300],
  }
}));
export default StyledButton;
