import React, { useState, useRef } from "react";
import axios, { CancelToken, isCancel } from "axios";
import {
  Container,
  Typography,
  Grid,
  Box,
  Button,
  useTheme,
} from "@mui/material";
import LinearProgress, {
  linearProgressClasses,
} from "@mui/material/LinearProgress";
import CircularProgress, {
  circularProgressClasses,
} from "@mui/material/CircularProgress";

import PropTypes from "prop-types";
import { styled } from "@mui/material/styles";

const BorderLinearProgress = styled(LinearProgress)(({ theme }) => ({
  height: 10,
  borderRadius: 5,
  [`&.${linearProgressClasses.colorPrimary}`]: {
    backgroundColor: theme.palette.grey[200],
    ...theme.applyStyles("dark", {
      backgroundColor: theme.palette.grey[800],
    }),
  },
  [`& .${linearProgressClasses.bar}`]: {
    borderRadius: 5,
    backgroundColor: theme.palette.secondary.main,
    ...theme.applyStyles("dark", {
      backgroundColor: "#308fe8",
    }),
  },
}));
function LinearProgressWithLabel(props) {
  return (
    <Box sx={{ display: "flex", alignItems: "center" }}>
      <Box sx={{ width: "100%", mr: 1 }}>
        <BorderLinearProgress variant="determinate" {...props} />
      </Box>
      <Box sx={{ minWidth: 35 }}>
        <Typography variant="body2" sx={{ color: "text.secondary" }}>
          {`${Math.round(props.value)}%`}
        </Typography>
      </Box>
    </Box>
  );
}

LinearProgressWithLabel.propTypes = {
  value: PropTypes.number.isRequired,
};

function DeterminateCircularProgress(props) {
  return (
    <Box sx={{ position: "relative" }}>
      <CircularProgress
        variant="determinate"
        sx={(theme) => ({
          color: theme.palette.secondary.main,
          ...theme.applyStyles("dark", {
            color: theme.palette.grey[800],
          }),
        })}
        size={40}
        thickness={4}
        {...props}
        value={100}
      />
    </Box>
  );
}
function IndeterminateCircularProgress(props) {
  return (
    <Box sx={{ position: "relative" }}>
      <CircularProgress
        variant="indeterminate"
        disableShrink
        sx={(theme) => ({
          color: theme.palette.secondary.main,
          animationDuration: "550ms",
          position: "absolute",
          left: 0,
          [`& .${circularProgressClasses.circle}`]: {
            strokeLinecap: "round",
          },
          ...theme.applyStyles("dark", {
            color: "#308fe8",
          }),
        })}
        size={40}
        thickness={4}
        {...props}
      />
    </Box>
  );
}
function CircularProgressWithLabel(props) {
  return (
    <Box sx={{ position: "relative", display: "inline-flex" }}>
      <DeterminateCircularProgress variant="determinate" {...props} />
      <Box
        sx={{
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          position: "absolute",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <Typography
          variant="caption"
          component="div"
          sx={{ color: "text.secondary" }}
        >
          {`${Math.round(props.value)}%`}
        </Typography>
      </Box>
    </Box>
  );
}

CircularProgressWithLabel.propTypes = {
  value: PropTypes.number.isRequired,
};

const FileUpload = () => {
  const [uploadPercentage, setUploadPercentage] = useState(0);
  const cancelFileUpload = useRef(null);
  const theme = useTheme();
  const uploadFile = ({ target: { files } }) => {
    let data = new FormData();
    data.append("file", files[0]);
    const options = {
      onUploadProgress: (progressEvent) => {
        const { loaded, total } = progressEvent;

        let percent = Math.floor((loaded * 100) / total);

        if (percent < 100) {
          setUploadPercentage(percent);
        }
      },
      cancelToken: new CancelToken(
        (cancel) => (cancelFileUpload.current = cancel)
      ),
    };

    axios
      .post(`${import.meta.env.VITE_REACT_APP_BASE_URL}/uploads`, data, options)
      .then((res) => {
        console.log(res);
        setUploadPercentage(100);

        setTimeout(() => {
          setUploadPercentage(0);
        }, 1000);
      })
      .catch((err) => {
        console.log(err);

        if (isCancel(err)) {
          alert(err.message);
        }
        setUploadPercentage(0);
      });
  };

  const cancelUpload = () => {
    if (cancelFileUpload.current)
      cancelFileUpload.current("User has canceled the file upload.");
  };

  return (
    <Container>
      <Grid container justifyContent="center" alignItems="center" spacing={2}>
        <Grid item xs={9} md={12} textAlign="center">
          <input
            type="file"
            onChange={uploadFile}
            style={{ margin: "20px 0", display: "block" }}
          />
          {uploadPercentage > 0 && (
            <Box mt={3}>
              <Grid container alignItems="center" mt={1}>
                <Grid item xs>
                  <LinearProgressWithLabel
                    theme={theme}
                    variant="determinate"
                    value={uploadPercentage}
                  />
                </Grid>
                <Grid item>
                  <Button color="success" onClick={cancelUpload}>
                    Cancel
                  </Button>
                </Grid>
              </Grid>
            </Box>
          )}
        </Grid>
      </Grid>
    </Container>
  );
};

export default FileUpload;
