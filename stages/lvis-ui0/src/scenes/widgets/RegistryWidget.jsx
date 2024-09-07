import {
  Box
} from "@mui/material";
import WidgetWrapper from "../../components/WidgetWrapper";
import UpdateUser from "../form/UpdateUser";


const RegistryWidget = ({ user }) => {
  return (
    <WidgetWrapper>
      <Box p="1rem 0">
        <UpdateUser user={user || {}}/>        
      </Box>
    </WidgetWrapper>
  );
};
export default RegistryWidget;
