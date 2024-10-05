import React, { useState } from "react";
import { Box, Button, TextField, useTheme } from "@mui/material";
import Header from "../../components/Header";
import {
  useGetCustomersQuery,
  useAddCustomerMutation,
  useUpdateCustomerMutation,
  useDeleteCustomerMutation,
} from "../../state/api";
import { DataGrid } from "@mui/x-data-grid";
import { countryData } from "../../data/mockData";

const Customers = () => {
  const theme = useTheme();
  const [sort, setSort] = useState({});
  const [search, setSearch] = useState("");
  const [searchInput, setSearchInput] = useState("");
  const [paginationModel, setPaginationModel] = useState({
    page: 0,
    pageSize: 20,
  });
  const { data, refetch } = useGetCustomersQuery({
    page: paginationModel.page,
    pageSize: paginationModel.pageSize,
    sort: JSON.stringify(sort),
    search,
  });
  const [rows, setRows] = useState([]);
  const [total, setTotal] = useState(-1);
  const [rowModesModel, setRowModesModel] = useState({});

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

  const handleUpdateCustomer = async (updatedData) => {
    await updateCustomer(updatedData);
    refetch();
  };

  const handleDeleteCustomer = async (id) => {
    await deleteCustomer(id);
    refetch();
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
      renderCell: (params) => (
        <Button
          color="secondary"
          onClick={() => handleDeleteCustomer(params.row._id)}
        >
          Delete
        </Button>
      ),
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
          rows={(data && data.customers) || []}
          columns={columns}
          pageSize={5}
        />
        <TextField
          label="Name"
          value={newCustomer.name}
          onChange={(e) => setNewCustomer({ ...newCustomer, name: e.target.value })}
        />
        <TextField
          label="Age"
          type="number"
          value={newCustomer.email}
          onChange={(e) =>
            setNewCustomer({ ...newCustomer, email: e.target.value })
          }
        />
        <Button onClick={handleAddCustomer}>Add Customer</Button>
      </Box>
    </Box>
  );
};

export default Customers;
