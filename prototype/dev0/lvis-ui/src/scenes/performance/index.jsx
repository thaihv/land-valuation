import React from "react";
import { Box, useTheme } from "@mui/material";
import { useGetUserPerformanceQuery } from "../../state/api";
import { useSelector } from "react-redux";
import { DataGrid } from "@mui/x-data-grid";
import Header from "../../components/Header";


const Performance = () => {
  const theme = useTheme();
  const user = useSelector((state) => state.global.user);
  const { data, isLoading } = useGetUserPerformanceQuery(user._id);
  
  const columns = [
    {
      field: "_id",
      headerName: "ID",
      flex: 1,
    },
    {
      field: "userId",
      headerName: "User ID",
      flex: 1,
    },
    {
      field: "createdAt",
      headerName: "CreatedAt",
      flex: 1,
    },
    {
      field: "products",
      headerName: "# of Products",
      flex: 0.5,
      sortable: false,
      renderCell: (params) => params.value.length,
    },
    {
      field: "cost",
      headerName: "Cost",
      flex: 1,
      renderCell: (params) => `$${Number(params.value).toFixed(2)}`,
    },
  ];

  return (
    <Box m="1.5rem 2.5rem">
      <Header
        title="PERFORMANCE"
        subtitle="Track your Affiliate Sales Performance Here"
      />
      <Box
        // mt="40px"
        // height="75vh"
        // sx={{
        //   "& .MuiDataGrid-root": {
        //     border: "none",
        //   },
        //   "& .MuiDataGrid-cell": {
        //     borderBottom: "none",
        //   },
        //   "& .MuiDataGrid-container--top [role=row]": {
        //     backgroundColor: `${theme.palette.neutral.main} !important`,
        //     borderBottom: "none",
        //   },
        //   "& .MuiDataGrid-virtualScroller": {
        //     backgroundColor: theme.palette.background.alt,
        //   },
        //   "& .MuiDataGrid-footerContainer": {
        //     backgroundColor: theme.palette.neutral.main,
        //     color: theme.palette.secondary[100],
        //     borderTop: "none",
        //   },
        //   "& .MuiDataGrid-toolbarContainer .MuiButton-text": {
        //     color: `${theme.palette.secondary[200]} !important`,
        //   },
        // }}
        mt="40px"
        height="75vh"
        display="grid"
        gridTemplateColumns="repeat(12, minmax(0, 1fr))"
        justifyContent="space-between"
        rowGap="20px"
        columnGap="1.33%"
        sx={{
          "& > div": { gridColumn: "span 12" },
          "& .MuiDataGrid-root": {
            border: "none",
          },
          "& .MuiDataGrid-cell": {
            borderBottom: "none",
          },
          "& .MuiDataGrid-container--top [role=row]": {
            backgroundColor: `${theme.palette.neutral.main} !important`,
            borderBottom: "none",
          },
          "& .MuiDataGrid-virtualScroller": {
            backgroundColor: theme.palette.background.alt,
          },
          "& .MuiDataGrid-footerContainer": {
            backgroundColor: theme.palette.neutral.main,
            color: theme.palette.secondary[100],
            borderTop: "none",
          },
          "& .MuiDataGrid-toolbarContainer .MuiButton-text": {
            color: `${theme.palette.secondary[200]} !important`,
          },          
        }}        
      >
        <DataGrid
          loading={isLoading || !data}
          getRowId={(row) => row._id}
          rows={(data && data.sales) || []}
          columns={columns}
          initialState={{
            pagination: {
              paginationModel: { pageSize: 5, page: 0 },
            },
          }}
          pageSizeOptions={[5, 10, 25]}
        />
      </Box>
    </Box>
  );
};

export default Performance;
