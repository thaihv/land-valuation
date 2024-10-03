import React, { useState } from "react";
import { Box, Button, useTheme } from "@mui/material";
import AddIcon from '@mui/icons-material/Add';
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/DeleteOutlined';
import SaveIcon from '@mui/icons-material/Save';
import CancelIcon from '@mui/icons-material/Close';
import Header from "../../components/Header";
import { useGetCustomersQuery } from "../../state/api";
import {
  GridRowModes,
  DataGrid,
  GridToolbarContainer,
  GridActionsCellItem,
  GridRowEditStopReasons,
} from '@mui/x-data-grid';
import {
  randomId
} from '@mui/x-data-grid-generator';


function EditToolbar(props) {
  const { setRows, setRowModesModel } = props;

  const handleClick = () => {
    const _id = randomId();
    setRows((oldRows) => [
      ...oldRows,
      { _id, name: '', email: '', phoneNumber: '', country: '', occupation: '', isNew: true },
    ]);
    setRowModesModel((oldModel) => ({
      ...oldModel,
      [_id]: { mode: GridRowModes.Edit, fieldToFocus: 'name' },
    }));
  };

  return (
    <GridToolbarContainer>
      <Button color="primary" startIcon={<AddIcon />} onClick={handleClick}>
        Add record
      </Button>
    </GridToolbarContainer>
  );
}

const Customers = () => {
  const theme = useTheme();
  const [sort, setSort] = useState({});
  const [search, setSearch] = useState("");
  const [searchInput, setSearchInput] = useState("");
  const [paginationModel, setPaginationModel] = useState({
    page: 0,
    pageSize: 20,
  });
  const { data, isLoading } = useGetCustomersQuery({
    page: paginationModel.page,
    pageSize: paginationModel.pageSize,
    sort: JSON.stringify(sort),
    search,
  }); 
  const [rows, setRows] = useState([]);
  const [total, setTotal] = useState(-1);
  const [rowModesModel, setRowModesModel] = useState({});


  const handleRowEditStop = (params, event) => {
    if (params.reason === GridRowEditStopReasons.rowFocusOut) {
      event.defaultMuiPrevented = true;
    }
  };

  const handleEditClick = (id) => () => {
    setRowModesModel({ ...rowModesModel, [id]: { mode: GridRowModes.Edit } });
  };

  const handleSaveClick = (id) => () => {
    setRowModesModel({ ...rowModesModel, [id]: { mode: GridRowModes.View } });
  };

  const handleDeleteClick = (id) => () => {
    setRows(rows.filter((row) => row._id !== id));
  };

  const handleCancelClick = (id) => () => {
    setRowModesModel({
      ...rowModesModel,
      [id]: { mode: GridRowModes.View, ignoreModifications: true },
    });

    const editedRow = rows.find((row) => row._id === id);
    if (editedRow.isNew) {
      setRows(rows.filter((row) => row._id !== id));
    }
  };

  const processRowUpdate = (newRow) => {
    const updatedRow = { ...newRow, isNew: false };
    setRows(rows.map((row) => (row._id === newRow._id ? updatedRow : row)));
    return updatedRow;
  };

  const handleRowModesModelChange = (newRowModesModel) => {
    setRowModesModel(newRowModesModel);
  };

  const handleStateChange = () => {
    if (data){
      if (!rows || rows.length == 0){
        setRows(data.customers);
        setTotal(data.total)
      }
    }
  }
  const columns = [
    {
      field: "_id",
      headerName: "ID",
      flex: 1,
    },
    {
      field: "name",
      headerName: "Name",
      editable: true,
      flex: 0.5,
    },
    {
      field: "email",
      headerName: "Email",
      editable: true,
      flex: 1,
    },
    {
      field: "phoneNumber",
      headerName: "Phone Number",
      editable: true,
      flex: 0.5,
      renderCell: (params) => {
        return params.value.replace(/^(\d{3})(\d{3})(\d{4})/, "($1)$2-$3");
      },
    },
    {
      field: "country",
      headerName: "Country",
      editable: true,
      flex: 0.4,
    },
    {
      field: "occupation",
      headerName: "Occupation",
      editable: true,
      flex: 1,
    },
    {
      field: "role",
      headerName: "Role",
      flex: 0.5,
    },
    {
      field: 'actions',
      type: 'actions',
      headerName: 'Actions',
      width: 100,
      cellClassName: 'actions',
      getActions: ({ id }) => {
        const isInEditMode = rowModesModel[id]?.mode === GridRowModes.Edit;

        if (isInEditMode) {
          return [
            <GridActionsCellItem
              icon={<SaveIcon />}
              label="Save"
              sx={{
                color: theme.palette.secondary[200],
              }}
              onClick={handleSaveClick(id)}
            />,
            <GridActionsCellItem
              icon={<CancelIcon />}
              label="Cancel"
              className="textPrimary"
              onClick={handleCancelClick(id)}
              color="inherit"
            />,
          ];
        }

        return [
          <GridActionsCellItem
            icon={<EditIcon />}
            label="Edit"
            className="textPrimary"
            onClick={handleEditClick(id)}
            color="inherit"
          />,
          <GridActionsCellItem
            icon={<DeleteIcon />}
            label="Delete"
            onClick={handleDeleteClick(id)}
            color="inherit"
          />,
        ];
      },
    },
  ];

  return (
    <Box m="1.5rem 2.5rem">
      <Header title="CUSTOMERS" subtitle="List of Customers" />
      <Box
        mt="20px"
        height="75vh"
        display="grid"
        gridTemplateColumns="repeat(12, minmax(0, 1fr))"
        justifyContent="space-between"
        rowGap="20px"
        columnGap="1.33%"
        sx={{
          "& > div": { gridColumn: "span 12" },
          width: '100%',
          '& .actions': {
            color: theme.palette.secondary[200],
          },
          '& .textPrimary': {
            color: theme.palette.secondary[200],
          },          
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
          onStateChange={handleStateChange}
          getRowId={(row) => row._id}
          rows={rows}
          columns={columns}
          editMode="row"
          rowModesModel={rowModesModel}
          rowCount={total}
          sortingMode="server"
          onSortModelChange={(newSortModel) => setSort(...newSortModel)}
          pagination
          paginationMode="server"
          pageSizeOptions={[10, 20, 50]}
          paginationModel={paginationModel}
          onPaginationModelChange={(newPaginationModel) => {
            setPaginationModel(newPaginationModel);
            setRows(data.customers);
            setTotal(data.total);
          }}          
          onRowModesModelChange={handleRowModesModelChange}
          onRowEditStop={handleRowEditStop}
          processRowUpdate={processRowUpdate}
          slots={{
            toolbar: EditToolbar,
          }}
          slotProps={{
            toolbar: { setRows, setRowModesModel },
            loadingOverlay: {
              variant: "skeleton",
              noRowsVariant: "skeleton",
            },            
          }}
          sx={{
            '& .MuiDataGrid-cell:hover': {
              color: theme.palette.secondary[200],
            },
            '& .MuiDataGrid-cell--editable': {
              bgcolor: "#f0f0f0",
              ...theme.applyStyles('dark', {
                bgcolor: "#191F45",
              }),
            },
          }}          
        />
      </Box>
    </Box>
  );
};

export default Customers;
