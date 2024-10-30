import React, { useState } from "react";
import { Box, TextField, useTheme } from "@mui/material";
import Grid from '@mui/material/Grid2';
import StyledButton from "../../components/custom/StyledButton";
import {
  useGetBookQuery,
  useGetBooksQuery,
  useAddBookMutation,
  useUpdateBookMutation,
  useDeleteBookMutation,
} from "../../state/egisApi";
import {
  GridRowModes,
  DataGrid,
  GridActionsCellItem,
  GridRowEditStopReasons,
} from "@mui/x-data-grid";
import EditIcon from "@mui/icons-material/Edit";
import DeleteIcon from "@mui/icons-material/DeleteOutlined";
import SaveIcon from "@mui/icons-material/Save";
import CancelIcon from "@mui/icons-material/Close";

function generateRandomId(length = 3) {
  const characters =
    "0123456789";
  let randomId = "";

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    randomId += characters[randomIndex];
  }
  return randomId;
}

const CrudDemo = () => {
  const theme = useTheme();
  const [sort, setSort] = useState({});
  const [search, setSearch] = useState("");
  const [paginationModel, setPaginationModel] = useState({
    page: 0,
    pageSize: 5,
  });
  const {
    data: items = [],
    isLoading,
    refetch,
  } = useGetBooksQuery({
    page: paginationModel.page,
    pageSize: paginationModel.pageSize,
    sort: JSON.stringify(sort),
    search,
  });
  const [addBook] = useAddBookMutation();
  const [updateBook] = useUpdateBookMutation();
  const [deleteBook] = useDeleteBookMutation();
  const [newBook, setNewBook] = useState({
    title: "",
    author: "",
  });
  const [rows, setRows] = useState(items);
  const [total, setTotal] = useState(items.length);
  const [rowModesModel, setRowModesModel] = useState({});

  // Function to check if any rows are in edit mode
  const isGridInEditMode = () => {
    return Object.values(rowModesModel).some(
      (rowMode) => rowMode.mode === GridRowModes.Edit
    );
  };
  // Handler to add a new item without editing in grid
  const handleAddBook = async () => {
    await addBook(newBook);
    setNewBook({
      title: "",
      author: "",
    });
    refetch();
  };
  const handleUpdateBook = async (updatedData) => {
    if (updatedData.isNew) {
      const { isNew, ...newOne } = updatedData;
      await addBook(newOne);
    } else {
      await updateBook(updatedData).unwrap();
    }
    refetch();
    return updatedData;
  };
  const handleUpdateBookError = (error) => {
    console.log(error);
  };
  const handleDeleteBook = async (id) => {
    await deleteBook(id);
    refetch();
  };

  // Handlers to control event process in mode Edit and View
  const handleRowModesModelChange = (newRowModesModel) => {
    setRowModesModel(newRowModesModel);
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
    setRowModesModel({ ...rowModesModel, [id]: { mode: GridRowModes.View } });
  };
  const handleCancelClick = (id) => () => {
    setRowModesModel({
      ...rowModesModel,
      [id]: { mode: GridRowModes.View, ignoreModifications: true },
    });
    const editedRow = rows.find((row) => row.id === id);
    if (editedRow.isNew) {
      setRows(rows.filter((row) => row.id !== id));
    }
  };
  const handleStateChange = () => {
    if (!isGridInEditMode() && items) {
      setRows(items);
      setTotal(items.length);
    }
  };
  const columns = [
    {
      field: "id",
      headerName: "ID",
      flex: 0.5,
    },
    {
      field: "author",
      headerName: "Author",
      editable: true,
      flex: 0.5,
    },    
    {
      field: "title",
      headerName: "Title",
      editable: true,
      flex: 1,
    },
    {
      field: "action",
      headerName: "Action",
      width: 90,
      cellClassName: "actions",
      renderCell: (params) => {
        const isInEditMode =
          rowModesModel[params.row.id]?.mode === GridRowModes.Edit;
        if (isInEditMode) {
          return [
            <GridActionsCellItem
              key="Save"
              icon={<SaveIcon />}
              label="Save"
              sx={{
                color: theme.palette.secondary[200],
              }}
              onClick={handleSaveClick(params.row.id)}
            />,
            <GridActionsCellItem
              key="Cancel"
              icon={<CancelIcon />}
              label="Cancel"
              className="textPrimary"
              onClick={handleCancelClick(params.row.id)}
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
            onClick={handleEditClick(params.row.id)}
            color="inherit"
          />,
          <GridActionsCellItem
            key="Delete"
            icon={<DeleteIcon />}
            label="Delete"
            onClick={() => handleDeleteBook(params.row.id)}
            color="inherit"
          />,
        ];
      },
    },
  ];

  return (
    <Box m="1.5rem 2.5rem">
      <Box
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
            backgroundColor: `${theme.palette.background.alt} !important`,
            color: theme.palette.secondary[100],
            borderBottom: "none",
          },
          "& .MuiDataGrid-virtualScroller": {
            backgroundColor: theme.palette.background.alt,
          },
          "& .MuiDataGrid-footerContainer": {
            backgroundColor: theme.palette.background.alt,
            color: theme.palette.secondary[100],
            borderTop: "none",
          },
          "& .MuiDataGrid-toolbarContainer .MuiButton-text": {
            color: `${theme.palette.secondary[200]} !important`,
          },
        }}
      >
        <DataGrid
          loading={isLoading || !rows}
          getRowId={(row) => row.id}
          rows={rows || []}
          columns={columns}
          rowCount={total || -1}
          sortingMode="server"
          editMode="row"
          onStateChange={handleStateChange}
          onSortModelChange={(newSortModel) => setSort(...newSortModel)}
          pagination
          paginationMode="server"
          pageSizeOptions={[5, 10, 20]}
          paginationModel={paginationModel}
          onPaginationModelChange={(newPaginationModel) => {
            setPaginationModel(newPaginationModel);
          }}
          rowModesModel={rowModesModel}
          onRowModesModelChange={handleRowModesModelChange}
          processRowUpdate={handleUpdateBook}
          onRowEditStop={handleRowEditStop}
          onProcessRowUpdateError={handleUpdateBookError}
          slotProps={{
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
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, sm: 4, md: 4 }}>
              <TextField
                label="Author"
                value={newBook.author}
                onChange={(e) =>
                  setNewBook({ ...newBook, author: e.target.value })
                }
              />
          </Grid>          
          <Grid size={{ xs: 12, sm: 4, md: 4 }}>
            <TextField
              label="Title"
              value={newBook.title}
              onChange={(e) =>
                setNewBook({ ...newBook, title: e.target.value })
              }
            />
          </Grid>
          <Grid size={{ xs: 12, sm: 4, md: 4 }}>
            <StyledButton
              fullWidth
              variant="contained"
              size="small"
              onClick={handleAddBook}
            >
              Add
            </StyledButton>
          </Grid>
        </Grid>
      </Box>
    </Box>
  );
};

export default CrudDemo;
