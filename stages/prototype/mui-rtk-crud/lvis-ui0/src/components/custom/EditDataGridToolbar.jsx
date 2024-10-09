import React from "react";
import { Search } from "@mui/icons-material";
import {
  IconButton,
  Button,
  TextField,
  MenuItem,
  useTheme,
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
  gridFilteredSortedRowIdsSelector,
  gridVisibleColumnFieldsSelector,
  useGridApiContext,
} from "@mui/x-data-grid";
import FlexBetween from "../FlexBetween";

const getJson = (apiRef) => {
  const filteredSortedRowIds = gridFilteredSortedRowIdsSelector(apiRef);
  const visibleColumnsField = gridVisibleColumnFieldsSelector(apiRef);
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
  includeCheckboxes: false,
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
const AddIcon = ({ fill, width, height }) => (
  <svg
    fill={fill}
    width={width}
    height={height} 
    viewBox="0 0 885.389 885.389"
  >
    <g>
      <path
        d="M560.988,212.188c-179.2,0-324.4,145.2-324.4,324.4s145.2,324.4,324.4,324.4c179.2,0,324.4-145.2,324.4-324.4
		S740.188,212.188,560.988,212.188z M745.789,570.188c0,11-9,20-20,20h-91.2c-11,0-20,9-20,20v91.2c0,11-9,20-20,20h-67.2
		c-11,0-20-9-20-20v-91.2c0-11-9-20-20-20H386.188c-5.5,0-10-4.5-10-10v-77.199c0-11,9-20,20-20h91.201c11,0,20-9,20-20v-91.2
		c0-11,9-20,20-20h67.2c11,0,20,9,20,20v91.2c0,11,9,20,20,20h91.2c11,0,20,9,20,20V570.188z"
      />
      <path
        d="M153.588,416.489c5.6,0.1,10.7-3.301,12.8-8.4l60.7-145.8c2-4.9,5.9-8.8,10.8-10.8l145.8-60.7c5.2-2.2,8.5-7.2,8.4-12.8
		c-0.101-5.6-3.601-10.6-8.8-12.6l-364.4-140.1c-5.1-1.9-10.8-0.7-14.6,3.1l-0.3,0.3c-3.8,3.8-5,9.6-3.1,14.6l140.1,364.399
		C142.988,412.989,147.988,416.489,153.588,416.489z"
      />
    </g>
  </svg>
);

const EditDataGridToolbar = ({
  searchInput,
  setSearchInput,
  setSearch,
  handleAddRowInGrid,
}) => {
  const theme = useTheme();
  const handleKeyPress = (e) => {
    if (e.keyCode == 13) {
      setSearch(searchInput);
    }
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
            startIcon={<AddIcon fill={theme.palette.secondary[200]} width="18px" height="18px" />}
            onClick={handleAddRowInGrid}
          >
            Add
          </Button>
        </FlexBetween>
        <TextField
          label="Search..."
          sx={{ mb: "0.5rem", width: "15rem" }}
          onKeyDown={handleKeyPress}
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

export default EditDataGridToolbar;
