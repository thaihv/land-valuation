import React, { useState, useRef } from "react";
import axios, { CancelToken, isCancel } from "axios";
import {
  Container,
  Grid,
  Box,
  Button,
  useTheme,
} from "@mui/material";
import LinearProgressBar from "../../components/progessbars/LinearProgressBar"

const FileUpload = () => {
  const [uploadPercentage, setUploadPercentage] = useState(0);
  const cancelFileUpload = useRef(null);
  const theme = useTheme();
  const uploadFile = (e) => {
    let data = new FormData();
    data.append("file", e.target.files[0]);

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
          e.target.value = '' // to clear the current file
        }, 1000);
      })
      .catch((err) => {
        console.log(err);

        if (isCancel(err)) {
          alert(err.message);
        }
        setUploadPercentage(0);
        e.target.value = '' // to clear the current file
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
            type="file" multiple
            onChange={uploadFile}
            style={{ margin: "20px 0", display: "block" }}
          />
          {uploadPercentage > 0 && (
            <Box mt={3}>
              <Grid container alignItems="center" mt={1}>
                <Grid item xs>
                  <LinearProgressBar
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