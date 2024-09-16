import React from 'react';
import { Container, Grid, Card, CardContent, Typography, Button, useTheme} from '@mui/material';
import DownloadIcon from '@mui/icons-material/Download';
import useFileDownloader from "../../hooks/useFileDownloader";

const files = [
  {
    name: "Photo 1",
    thumb:
      "https://images.unsplash.com/photo-1604263439201-171fb8c0fddc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=427&q=80 427w",
    file:
      "https://images.unsplash.com/photo-1604263439201-171fb8c0fddc?rnd=" +
      Math.random(),
    filename: "photo-1.jpg",
  },
  {
    name: "Photo 2",
    thumb:
      "https://images.unsplash.com/photo-1604164388977-1b6250ef26f3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=401&q=80 401w",
    file:
      "https://images.unsplash.com/photo-1604164388977-1b6250ef26f3?rnd=" +
      Math.random(),
    filename: "photo-2.jpg",
  },
  {
    name: "Photo 3",
    thumb:
      "https://images.unsplash.com/photo-1604264849633-67b1ea2ce0a4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80 750w",
    file:
      "https://images.unsplash.com/photo-1604264849633-67b1ea2ce0a4?rnd=" +
      Math.random(),
    filename: "photo-3.jpg",
  },
];

const FileDownloader = () => {
  const [downloadFile, downloaderComponentUI] = useFileDownloader();
  const theme = useTheme();
  const download = (file) => downloadFile(file);

  return (
    <Container>
      <Grid container spacing={3}>
        {files.map((file, idx) => (
          <Grid item xs={12} sm={6} md={4} key={idx}>
            <Card>
              <CardContent>
                <img
                  src={file.thumb}
                  alt={file.name}
                  style={{ width: '100%', height: 'auto', marginBottom: 16 }}
                />
                <Typography variant="h5" gutterBottom>
                  {file.name}
                </Typography>
                <Button
                  sx={{
                    backgroundColor: theme.palette.background.default,
                    color: theme.palette.neutral.dark,
                    fontSize: "12px",
                    fontWeight: "bold",
                    padding: "10px 20px",
                    borderRadius: "25px",
                    "&:hover": {
                      bgcolor: theme.palette.secondary.main,
                    },
                  }}
                  variant="contained"
                  size="small"                  
                  onClick={() => download(file)}
                  endIcon={<DownloadIcon />}
                >
                  Download
                </Button>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
      {downloaderComponentUI}
    </Container>
  );
};

export default FileDownloader;