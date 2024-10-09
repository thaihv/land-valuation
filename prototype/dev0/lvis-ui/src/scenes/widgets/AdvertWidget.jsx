import { Typography, useTheme } from "@mui/material";
import FlexBetween from "../../components/FlexBetween";
import WidgetWrapper from "../../components/WidgetWrapper";

const AdvertWidget = ({ category, homelink, picture, description }) => {
  const { palette } = useTheme();
  const dark = palette.neutral.dark;
  const main = palette.neutral.main;
  const medium = palette.neutral.medium;

  return (
    <WidgetWrapper>
      <FlexBetween>
        <Typography color={dark} variant="h5" fontWeight="500">
          Sponsored
        </Typography>
        <Typography color={medium}>Create Ad</Typography>
      </FlexBetween>
      <img
        width="100%"
        height="auto"
        alt="advert"
        src={`${import.meta.env.VITE_REACT_APP_BASE_URL}/assets/${picture}`}
        style={{ borderRadius: "0.75rem", margin: "0.75rem 0" }}
      />
      <FlexBetween>
        <Typography color={main}>{category}</Typography>
        <Typography color={medium}>{homelink}</Typography>
      </FlexBetween>
      <Typography color={medium} m="0.5rem 0">
        {description}
      </Typography>
    </WidgetWrapper>
  );
};
export default AdvertWidget;
