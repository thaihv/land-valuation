import React, { useState } from "react";
import {
  Box,
  Select,
  TextField,
  MenuItem,
  useTheme,
} from "@mui/material";
import Header from "../../components/Header";
import StyledButton from "../../components/custom/StyledButton";
import {
  useGetCustomersQuery,
  useAddCustomerMutation,
  useUpdateCustomerMutation,
  useDeleteCustomerMutation,
} from "../../state/api";
import { 
  GridRowModes,
  DataGrid,
  GridActionsCellItem,
  GridRowEditStopReasons,
} from "@mui/x-data-grid";
import EditDataGridToolbar from "../../components/custom/EditDataGridToolbar";
import EditIcon from "@mui/icons-material/Edit";
import DeleteIcon from "@mui/icons-material/DeleteOutlined";
import SaveIcon from "@mui/icons-material/Save";
import CancelIcon from "@mui/icons-material/Close";
import { countryData } from "../../data/mockData";



function generateRandomId(length = 24) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let randomId = '';
  
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    randomId += characters[randomIndex];
  }

  return randomId;
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
  const { data: items = [], refetch } = useGetCustomersQuery({
    page: paginationModel.page,
    pageSize: paginationModel.pageSize,
    sort: JSON.stringify(sort),
    search,
  });

  const [addCustomer] = useAddCustomerMutation();
  const [updateCustomer] = useUpdateCustomerMutation();
  const [deleteCustomer] = useDeleteCustomerMutation();
  const [newCustomer, setNewCustomer] = useState({
    name: "",
    email: "",
    phoneNumber: "",
    country: "VN",
    occupation: "",
    role: "user",
  });

  const [rows, setRows] = useState(items.customers);
  const [total, setTotal] = useState(items.total);
  const [rowModesModel, setRowModesModel] = useState({});

  // Handler TO add a new item without editing in grid
  const handleAddCustomer = async () => {
    await addCustomer(newCustomer);
    setNewCustomer({
      name: "",
      email: "",
      phoneNumber: "",
      country: "VN",
      occupation: "",
      role: "user",
    });
    refetch();
  };
  const handleUpdateCustomerError = (error) => {
    console.log(error);
  };
  const handleUpdateCustomer = async (updatedData) => {
    if (updatedData.isNew === true) {
      const {isNew, ...newOne} = updatedData;
      await addCustomer(newOne);
      refetch();
    }
    else {
      await updateCustomer(updatedData).unwrap();
      refetch();
    }

    const updatedRow = { ...updatedData, isNew: false };
    setRows(rows.map((row) => (row._id === updatedData._id ? updatedRow : row)));
    return updatedRow;
  };

  const handleDeleteCustomer = async (id) => {    
    await deleteCustomer(id);
    refetch();

    setRows(rows.filter((row) => row._id !== id));
    setTotal(rows.length);    
  };
  const handleRowModesModelChange = (newRowModesModel) => {
    setRowModesModel(newRowModesModel);
  };
  // Handler TO add a new item by editing in grid using toolbar
  const handleAddNew = async () => {
    const _id = generateRandomId();
    setRows((oldRows) => [
      ...oldRows,
      {
        _id,
        name: "",
        email: "",
        phoneNumber: "",
        country: "VN",
        occupation: "",
        role: "user",
        isNew: true,
      },
    ]);
    setRowModesModel((oldModel) => ({
      ...oldModel,
      [_id]: { mode: GridRowModes.Edit, fieldToFocus: "name" },
    }));
  };

  const handleEditClick = (id) => () => {
    setRowModesModel((oldModel) => ({
      ...oldModel,
      [id]: { mode: GridRowModes.Edit, fieldToFocus: "name" },
    }));
  };
  const handleRowEditStop = (params, event) => {
    if (params.reason === GridRowEditStopReasons.rowFocusOut) {
      event.defaultMuiPrevented = true;
    }
    
  };
  const handleSaveClick = (id) => () => {
    setRowModesModel({ ...rowModesModel, [id]: {mode: GridRowModes.View } });
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
  const handleStateChange = () => {
    if (items) {
      if (!rows || rows.length == 0) {
        setRows(items.customers);
        setTotal(items.total);
      }
    }
  };
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
      type: "singleSelect",
      valueOptions: countryData,
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
      editable: true,
      type: "singleSelect",
      valueOptions: [
        { value: "user", label: "User" },
        { value: "admin", label: "Admin" },
      ],
    },
    {
      field: "action",
      headerName: "Action",
      width: 150,
      cellClassName: "actions",
      renderCell: (params) => {
        const isInEditMode = rowModesModel[params.row._id]?.mode === GridRowModes.Edit;
        if (isInEditMode) {
          return [
            <GridActionsCellItem
              key="Save"
              icon={<SaveIcon />}
              label="Save"
              sx={{
                color: theme.palette.secondary[200],
              }}
              onClick={handleSaveClick(params.row._id)}
            />,
            <GridActionsCellItem
              key="Cancel"
              icon={<CancelIcon />}
              label="Cancel"
              className="textPrimary"
              onClick={handleCancelClick(params.row._id)}
              color="inherit"
            />,
          ];
        }
        return [
          <GridActionsCellItem
            key="Edit"
            icon={<EditIcon />}
            label="Edit"
            className="textPrimary"
            onClick={handleEditClick(params.row._id)}
            color="inherit"
          />,
          <GridActionsCellItem
            key="Delete"
            icon={<DeleteIcon />}
            label="Delete"
            onClick={() => handleDeleteCustomer(params.row._id)}
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
          width: "100%",
          "& .actions": {
            color: theme.palette.secondary[200],
          },
          "& .textPrimary": {
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
          getRowId={(row) => row._id}
          rows={rows || []}
          columns={columns}
          rowCount={total || -1}
          sortingMode="server"
          editMode="row"
          onStateChange={handleStateChange}
          onSortModelChange={(newSortModel) => setSort(...newSortModel)}
          pagination
          paginationMode="server"
          pageSizeOptions={[10, 20, 50]}
          paginationModel={paginationModel}
          onPaginationModelChange={(newPaginationModel) => {
            setPaginationModel(newPaginationModel);
            setRows(items.customers);
            setTotal(items.total);
          }}
          rowModesModel={rowModesModel}
          onRowModesModelChange={handleRowModesModelChange}
          processRowUpdate={handleUpdateCustomer}
          onRowEditStop={handleRowEditStop}
          onProcessRowUpdateError={handleUpdateCustomerError}
          slots={{
            toolbar: EditDataGridToolbar,
          }}
          slotProps={{
            toolbar: { searchInput, setSearchInput, setSearch, handleAddNew },
            loadingOverlay: {
              variant: "skeleton",
              noRowsVariant: "skeleton",
            },
          }}
          sx={{
            "& .MuiDataGrid-cell:hover": {
              color: theme.palette.secondary[200],
            },
            "& .MuiDataGrid-cell--editable": {
              bgcolor: "#f0f0f0",
              ...theme.applyStyles("dark", {
                bgcolor: "#191F45",
              }),
            },
          }}                    
        />
        <Box display="flex" gap="2px" justifyContent="flex-start">
          <TextField
            label="Name"
            value={newCustomer.name}
            onChange={(e) =>
              setNewCustomer({ ...newCustomer, name: e.target.value })
            }
          />
          <TextField
            label="Email"
            value={newCustomer.email}
            onChange={(e) =>
              setNewCustomer({ ...newCustomer, email: e.target.value })
            }
          />
          <TextField
            label="Phone Number"
            type="number"
            value={newCustomer.phoneNumber}
            onChange={(e) =>
              setNewCustomer({ ...newCustomer, phoneNumber: e.target.value })
            }
          />
          <Select
            labelId="country-select-label"
            id="country-select"
            value={newCustomer.country}
            label="Country"
            onChange={(e) =>
              setNewCustomer({ ...newCustomer, country: e.target.value })
            }
          >
            <MenuItem value="VN">Viet Nam</MenuItem>
            <MenuItem value="CN">China</MenuItem>
            <MenuItem value="US">America</MenuItem>
          </Select>
          <TextField
            label="Occupation"
            value={newCustomer.occupation}
            onChange={(e) =>
              setNewCustomer({ ...newCustomer, occupation: e.target.value })
            }
          />
          <Select
            labelId="role-select-label"
            id="role-select"
            value={newCustomer.role}
            label="Role"
            onChange={(e) =>
              setNewCustomer({ ...newCustomer, role: e.target.value })
            }
          >
            <MenuItem value="user">User</MenuItem>
            <MenuItem value="admin">Admin</MenuItem>
          </Select>
          <StyledButton onClick={handleAddCustomer}>Add</StyledButton>
        </Box>
      </Box>
    </Box>
  );
};

export default Customers;
