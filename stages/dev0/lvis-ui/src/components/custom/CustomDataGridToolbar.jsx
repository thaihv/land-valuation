import React from "react";
import { Search } from "@mui/icons-material";
import {
  IconButton,
  Button,
  TextField,
  MenuItem,
  InputAdornment,
} from "@mui/material";
import {
  GridToolbarDensitySelector,
  GridToolbarContainer,
  GridToolbarColumnsButton,
  GridToolbarFilterButton,
  GridToolbarExportContainer,
  GridCsvExportMenuItem,
  GridPrintExportMenuItem,
  gridExpandedSortedRowIdsSelector,
  gridFilteredSortedRowIdsSelector,
  gridSortedRowIdsSelector,
  gridPaginatedVisibleSortedGridRowIdsSelector,
  gridVisibleColumnFieldsSelector,
  useGridApiContext,
} from "@mui/x-data-grid";
import FlexBetween from "../FlexBetween";
import { createSvgIcon } from "@mui/material/utils";

const getRowsFromCurrentPage = ({ apiRef }) => gridPaginatedVisibleSortedGridRowIdsSelector(apiRef);
const getUnfilteredRows = ({ apiRef }) => gridSortedRowIdsSelector(apiRef);
const getFilteredRows = ({ apiRef }) => gridExpandedSortedRowIdsSelector(apiRef);

const getJson = (apiRef) => {
  // Select rows and columns
  const filteredSortedRowIds = gridFilteredSortedRowIdsSelector(apiRef);
  const visibleColumnsField = gridVisibleColumnFieldsSelector(apiRef);
  // Format the data. Here we only keep the value
  const data = filteredSortedRowIds.map((id) => {
    const row = {};
    visibleColumnsField.forEach((field) => {
      row[field] = apiRef.current.getCellParams(id, field).value;
    });
    return row;
  });
  return JSON.stringify(data, null, 2);
};

const exportBlob = (blob, filename) => {
  // Save the blob in a json file
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  a.click();
  setTimeout(() => {
    URL.revokeObjectURL(url);
  });
};

function JsonExportMenuItem(props) {
  const apiRef = useGridApiContext();
  const { hideMenu } = props;
  return (
    <MenuItem
      onClick={() => {
        const jsonString = getJson(apiRef);
        const blob = new Blob([jsonString], {
          type: "text/json",
        });
        exportBlob(blob, "lvis_filter_visible_column.json");

        // Hide the export menu after the export
        hideMenu?.();
      }}
    >
      Download as JSON
    </MenuItem>
  );
}
const csvOptions = {
  fileName: "lvis_datagrid",
  delimiter: ";",
  utf8WithBom: true,
};
const printOptions = {
  hideFooter: true,
  hideToolbar: true,
  includeCheckboxes: true,
};

function CustomExportButton(props) {
  return (
    <GridToolbarExportContainer {...props}>
      <GridCsvExportMenuItem options={csvOptions} />
      <JsonExportMenuItem />
      <GridPrintExportMenuItem options={printOptions} />
    </GridToolbarExportContainer>
  );
}

const ExportIcon = createSvgIcon(
  <svg
    width="24"
    height="24"
    viewBox="0 0 32 32"
    fill="#997d3d"
    xmlns="http://www.w3.org/2000/svg"
  >
    <circle cx="16.0003" cy="16" r="9.33333" stroke="#997d3d" />
    <circle cx="15.9997" cy="16" r="2.66667" fill="white" stroke="white" />
    <path d="M16 6.66667V4" stroke="white" strokeLinecap="round" />
    <path d="M25.3333 16L28 16" stroke="white" strokeLinecap="round" />
    <path d="M16 28L16 25.3333" stroke="white" strokeLinecap="round" />
    <path d="M4.00032 16H6.66699" stroke="white" strokeLinecap="round" />
  </svg>
);

const CustomDataGridToolbar = ({ searchInput, setSearchInput, setSearch }) => {
  const apiRef = useGridApiContext();
  const handleExport = (options) => apiRef.current.exportDataAsCsv(options);
  const buttonBaseProps = {
    color: "primary",
    size: "small",
    startIcon: <ExportIcon />,
  };

  return (
    <GridToolbarContainer>
      <FlexBetween width="100%">
        <FlexBetween>
          <GridToolbarColumnsButton />
          <GridToolbarDensitySelector />
          <GridToolbarFilterButton />
          <CustomExportButton />
          <Button
            {...buttonBaseProps}
            onClick={() => handleExport({ getRowsToExport: getFilteredRows })}
          >
            MyOne
          </Button>
        </FlexBetween>
        <TextField
          label="Search..."
          sx={{ mb: "0.5rem", width: "15rem" }}
          onChange={(e) => setSearchInput(e.target.value)}
          value={searchInput}
          variant="standard"
          slotProps={{
            input: {
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton
                    onClick={() => {
                      setSearch(searchInput);
                      setSearchInput("");
                    }}
                  >
                    <Search />
                  </IconButton>
                </InputAdornment>
              ),
            },
          }}
        />
      </FlexBetween>
    </GridToolbarContainer>
  );
};

export default CustomDataGridToolbar;
