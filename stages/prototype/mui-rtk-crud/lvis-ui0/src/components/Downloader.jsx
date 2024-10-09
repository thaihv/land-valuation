import React, { useEffect, useState } from "react";
import { styled } from "@mui/material/styles";
import {
  Card,
  CardHeader,
  List,
  ListItem,
  Typography,
  Box,
  Chip,
  useMediaQuery
} from "@mui/material";
import LinearProgressBar from "../components/progessbars/LinearProgressBar"
import CheckCircleIcon from "@mui/icons-material/CheckCircle";
import Axios from "axios";

const DownloadItem = ({ name, file, filename, removeFile }) => {
  const [downloadInfo, setDownloadInfo] = useState({
    progress: 0,
    completed: false,
    total: 0,
    loaded: 0,
  });

  // useEffect will make Axios.get fire twice in React.StrictMode of dev mode
  // but not happen in production mode
  useEffect(() => {  
    const options = {
      onDownloadProgress: (progressEvent) => {
        const { loaded, total } = progressEvent;

        setDownloadInfo({
          progress: Math.floor((loaded * 100) / total),
          loaded,
          total,
          completed: false,
        });
      },
    };

    Axios.get(file, {
      responseType: "blob",
      ...options,
    }).then(function (response) {
      console.log(response);

      const url = window.URL.createObjectURL(
        new Blob([response.data], {
          type: response.headers["content-type"],
        })
      );

      const link = document.createElement("a");
      link.href = url;
      link.setAttribute("download", filename);
      document.body.appendChild(link);
      link.click();

      setDownloadInfo((info) => ({
        ...info,
        completed: true,
      }));

      setTimeout(() => {
        removeFile();
      }, 4000);
    });
  }, [file, filename, removeFile]);

  const formatBytes = (bytes) => `${(bytes / (1024 * 1024)).toFixed(2)} MB`;

  return (
    <Box sx={{ borderBottom: "1px solid #ddd", padding: 2 }}>
      <Box display="flex" alignItems="center">
        <Typography variant="body1" fontWeight="bold" noWrap>
          {name}
        </Typography>
        <Box ml={5}>
          <Typography variant="caption">
            {downloadInfo.loaded > 0 ? (
              <>
                <span style={{ color: "green" }}>
                  {formatBytes(downloadInfo.loaded)}
                </span>
                / {formatBytes(downloadInfo.total)}
              </>
            ) : (
              <>Download Initializing...</>
            )}
          </Typography>
        </Box>
        <Box ml={20}>
          {downloadInfo.completed && (
            <Chip
              label="Completed"
              icon={<CheckCircleIcon />}
              color="success"
              variant="outlined"
            />
          )}
        </Box>
      </Box>
      <Box mt={2}>
        <LinearProgressBar
          variant="determinate"
          value={downloadInfo.progress}
          sx={{ height: 10, borderRadius: 5 }}
        />
      </Box>
    </Box>
  );
};

const DownloaderContainer = styled("div")(({ theme , isNonMobile}) => ({
  width: 
    isNonMobile 
    ? 500
    : 300,
  minHeight: 128,
  position: "fixed",
  right: theme.spacing(2),
  bottom: theme.spacing(2),
  maxHeight: 700,
  overflowY: "auto",
}));

const CustomCard = styled(Card)(({ theme }) => ({
  height: "100%",
}));

const CustomCardHeader = styled(CardHeader)(({ theme }) => ({
  color: theme.palette.background.atl,
  backgroundColor: theme.palette.secondary.main,
}));

const CustomList = styled(List)(({ theme }) => ({
  maxHeight: 300,
  overflow: "hidden",
  overflowY: "auto",
}));

const Downloader = ({ files = [], remove }) => {
  const isNonMobile = useMediaQuery("(min-width: 600px)");
  return (
    <DownloaderContainer isNonMobile={isNonMobile}>
      <CustomCard>
        <CustomCardHeader 
          title="File Downloader"
          subheader={new Date().toLocaleString() + ""}
        >
        </CustomCardHeader>        
        <CustomList>
          {files.map((file, idx) => (
            <ListItem key={idx}>
              <DownloadItem
                removeFile={() => remove(file.downloadId)}
                {...file}
              />
            </ListItem>
          ))}
        </CustomList>
      </CustomCard>
    </DownloaderContainer>
  );
};
export default Downloader;
