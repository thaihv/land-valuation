import { 
  Box, 
  useMediaQuery, 
} from "@mui/material";
import TopBox from "../../components/TopBox";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import { useParams } from "react-router-dom";
import AdvertWidget from "../widgets/AdvertWidget";
import UserWidget from "../widgets/UserWidget";
import UpdateUser from "../form/UpdateUser";

const Profile = () => {
  const [user, setUser] = useState(null);
  const { id } = useParams();
  const token = useSelector((state) => state.token);
  const isNonMobileScreens = useMediaQuery("(min-width:1000px)");

  const getUser = async () => {
    const response = await fetch(`${import.meta.env.VITE_REACT_APP_BASE_URL}/general/user/${id}`, {
      method: "GET",
      headers: { Authorization: `Bearer ${token}` },
    });
    const data = await response.json();
    setUser(data);
  };

  useEffect(() => {
    getUser();
  }, []);

  if (!user) return null;

  return (
    <Box>
      <TopBox /> 
      <Box
        sx={{
          width: "100%",
          height: "21px",
          padding: "2px 2px 2px 2px", 
          bgcolor: "#002868",
          opacity: "0.5",
          mt: "3rem",
        }}     
      >
      </Box>
      <Box
        width="100%"
        padding="2rem 6%"
        display={isNonMobileScreens ? "flex" : "block"}
        gap="2rem"
        justifyContent="center"
      >
        <Box 
          flexBasis={isNonMobileScreens ? "26%" : undefined}
          mt={isNonMobileScreens ? undefined : "2rem"}
        >
          <UserWidget userId={id} picturePath={user.picturePath} />
        </Box>
        <Box 
          flexBasis={isNonMobileScreens ? "42%" : undefined}
          mt={isNonMobileScreens ? undefined : "2rem"}
        >
          <UpdateUser user={user} />
        </Box>
        <Box
          flexBasis={isNonMobileScreens ? "26%" : undefined}
          mt={isNonMobileScreens ? undefined : "2rem"}
        >
          <AdvertWidget 
            category="Cosmetics" 
            homelink="searchmenow.com" 
            picture="info3.jpeg"
            description="1488A High pigment cosmetics all in one Ladies Makeup kit box for professional full cosmetic makeup vanity cosmetic box set." 
          />
          <Box m="2rem 0" />
          <AdvertWidget 
            category="Foods" 
            homelink="mykfc.com" 
            picture="info2.jpeg"
            description="Yummy Food Steak Hamburger Salmon Art Prints Kitchen Poster Wall Home Decoration." 
          />
        </Box>
      </Box>
    </Box>
  );
};

export default Profile;
