import React, { useState, useRef } from "react";
import axios, { CancelToken, isCancel } from "axios";
import { Container, Typography, Grid, LinearProgress, Box, Button, useTheme } from "@mui/material";

const FileUpload = () => {
    const [uploadPercentage, setUploadPercentage] = useState(0);
    const cancelFileUpload = useRef(null);
    const theme = useTheme();
    const uploadFile = ({ target: { files } }) => {
        let data = new FormData();
        data.append("file", files[0]);
        const { name } = files[0];
        const options = {
            onUploadProgress: progressEvent => {
                const { loaded, total } = progressEvent;

                let percent = Math.floor((loaded * 100) / total);

                if (percent < 100) {
                    setUploadPercentage(percent);
                }
            },
            cancelToken: new CancelToken(
                cancel => (cancelFileUpload.current = cancel)
            )
        };

        axios
            .post(
                `${import.meta.env.VITE_REACT_APP_BASE_URL}/uploads`,
                data,
                options
            )
            .then(res => {
                console.log(res);
                setUploadPercentage(100);

                setTimeout(() => {
                    setUploadPercentage(0);
                }, 1000);
            })
            .catch(err => {
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
          <Grid item xs={12} md={6} textAlign="center">
            <input
              type="file"
              onChange={uploadFile}
              style={{ margin: '20px 0', display: 'block' }}
            />
            {uploadPercentage > 0 && (
              <Box mt={3}>
                <LinearProgress variant="determinate" value={uploadPercentage} />
                <Grid container alignItems="center" mt={1}>
                  <Grid item xs>
                    <Typography variant="body2" color={theme.palette.secondary.main}>
                      {uploadPercentage}%
                    </Typography>
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
