import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  mode: "light",
  userId: "63701cc1f03239d40b000044",
};

export const globalSlice = createSlice({
  name: "global",
  initialState,
  reducers: {
    setMode: (state) => {
      state.mode = state.mode === "light" ? "dark" : "light";
    },
  },
});

export const { setMode } = globalSlice.actions;

export default globalSlice.reducer;
