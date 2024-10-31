import React, { useState, useRef } from "react";
import axios, { CancelToken, isCancel } from "axios";
import {
  Container,
  Box,
  Button,
} from "@mui/material";
import Grid from '@mui/material/Grid2';
import LinearProgressBar from "../../components/progessbars/LinearProgressBar"
import UserService from "../../state/UserService";

const FileUpload = () => {
  const [uploadPercentage, setUploadPercentage] = useState(0);
  const cancelFileUpload = useRef(null);
  const uploadFile = (e) => {
    let data = new FormData();
    data.append("file", e.target.files[0]);
    const token = UserService.getToken() || localStorage.getItem('token');
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
      headers: {
        Authorization: `Bearer ${token}`, 
      }
    };
    axios
      .post(`${import.meta.env.VITE_PROTOTYPE_API_BASE_URL}/uploads`, data, options)
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
        <Grid size={{ xs: 9, md: 12 }} textAlign="center">
          <input
            type="file" multiple
            onChange={uploadFile}
            style={{ margin: "20px 0", display: "block" }}
          />
        </Grid>
        {uploadPercentage > 0 && (
          <Box sx={{ flexGrow: 1 }} mt={3}>
            <Grid container alignItems="center" mt={1}>
              <Grid size={{ xs: 9, md: 10 }}>
                <LinearProgressBar
                  variant="determinate"
                  value={uploadPercentage}
                />
              </Grid>
              <Grid size={{ xs: 3, md: 2 }}>
                <Button color="success" onClick={cancelUpload}>
                  Cancel
                </Button>
              </Grid>
            </Grid>
          </Box>
        )}
      </Grid>
    </Container>
  );
};

export default FileUpload;
