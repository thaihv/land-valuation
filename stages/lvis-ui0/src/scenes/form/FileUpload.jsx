import React, { useState, useRef } from "react";
import axios, { CancelToken, isCancel } from "axios";
import { Box, Button, TextField, useTheme } from "@mui/material";
import UploadFileOutlinedIcon from '@mui/icons-material/UploadFileOutlined';
const FileUpload = () => {
    const [uploadPercentage, setUploadPercentage] = useState(0);
    const cancelFileUpload = useRef(null);
    const [filename, setFilename] = useState("");

    const uploadFile = ({ target: { files } }) => {
        let data = new FormData();
        data.append("file", files[0]);
        const { name } = files[0];
        setFilename(name);
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
        <>
            <Button 
                variant="contained" 
                component="label"
                startIcon={<UploadFileOutlinedIcon />}
                sx={{ marginRight: "1rem" }}
            >
                Upload File
                <input
                    type="file"
                    hidden
                    onChange={uploadFile}
                />
            </Button>
            <Box>{filename}</Box>
        </>
    );
};

export default FileUpload;
