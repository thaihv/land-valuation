import React, { useState } from "react";
import { Box, useTheme } from "@mui/material";
import { DataGrid } from "@mui/x-data-grid";
import { useGetTransactionsQuery } from "../../state/prototypeApi";
import Header from "../../components/Header";
import BasicDataGridToolbar from "../../components/custom/BasicDataGridToolbar";

const Transactions = () => {
  const theme = useTheme();
  // values to be sent to the backend
  const [sort, setSort] = useState({});
  const [search, setSearch] = useState("");
  const [searchInput, setSearchInput] = useState("");
  const [paginationModel, setPaginationModel] = useState({
    page: 0,
    pageSize: 20,
  });
  const { data, isLoading } = useGetTransactionsQuery({
    page: paginationModel.page,
    pageSize: paginationModel.pageSize,
    sort: JSON.stringify(sort),
    search,
  });

  const columns = [
    {
      field: "_id",
      headerName: "ID",
      flex: 1,
    },
    {
      field: "userId",
      headerName: "User ID",
      editable: true,
      flex: 1,
    },
    {
      field: "createdAt",
      headerName: "CreatedAt",
      editable: true,
      flex: 1,
    },
    {
      field: "products",
      headerName: "# of Products",
      flex: 0.5,
      sortable: false,
      description: "This column has a description on product and is sortable.",
      renderCell: (params) => params.value.length,
    },
    {
      field: "cost",
      headerName: "Cost",
      width: 190,
      editable: true,
      renderCell: (params) => `$${Number(params.value).toFixed(2)}`,
    },
  ];

  return (
    <Box m="1.5rem 2.5rem">
      <Header title="TRANSACTIONS" subtitle="Entire list of transactions" />
      <Box
        height="80vh"
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
            color: theme.palette.secondary[100],
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
          // "& .MuiCheckbox-root": {
          //   color: `${theme.palette.secondary[200]} !important`,
          // },
        }}
      >
        <DataGrid    
          loading={isLoading || !data}
          getRowId={(row) => row._id}
          rows={(data && data.transactions) || []}
          columns={columns}
          rowCount={(data && data.total) || 0} //in case of Unknown row count set it -1
          sortingMode="server"
          onSortModelChange={(newSortModel) => setSort(...newSortModel)}
          pagination
          paginationMode="server"
          pageSizeOptions={[10, 20, 50]}
          paginationModel={paginationModel}
          onPaginationModelChange={(newPaginationModel) =>
            setPaginationModel(newPaginationModel)
          }
          checkboxSelection
          disableRowSelectionOnClick
          slots={{ toolbar: BasicDataGridToolbar }}
          slotProps={{
            toolbar: { searchInput, setSearchInput, setSearch },
            loadingOverlay: {
              variant: "skeleton",
              noRowsVariant: "skeleton",
            },
          }}
          sx={{
            '& .MuiDataGrid-cell:hover': {
              color: theme.palette.secondary[200],
            },
            '@media print': {
              '.MuiDataGrid-main': {
                width: "fit-content",
                fontSize: "14px",
                height: "fit-content",
                overflow: "visible",
              },
              marginBottom: "20px",
            },
          }}
        />
      </Box>
    </Box>
  );
};

export default Transactions;
