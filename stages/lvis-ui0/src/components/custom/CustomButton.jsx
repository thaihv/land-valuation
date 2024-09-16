import { Button } from "@mui/material";
import { styled } from "@mui/system";


const CustomButton = styled(Button)(({ theme }) => ({     
  backgroundColor: theme.palette.background.default,
  color: theme.palette.neutral.dark,
  fontSize: "12px",
  fontWeight: "bold",
  padding: "10px 20px",
  borderRadius: "15px",
  "&:hover": {
    bgcolor: theme.palette.secondary.main,
  },
}));
export default CustomButton;
