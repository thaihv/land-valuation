import { createSlice } from "@reduxjs/toolkit";
import { getKeycloak } from './UserService';

const initialState = {
  mode: "light",
  isAuthenticated: false,
  user: null,
  token: null,
};

export const globalSlice = createSlice({
  name: "global",
  initialState,
  reducers: {
    setMode: (state) => {
      state.mode = state.mode === "light" ? "dark" : "light";
    },
    setAuthState: (state, action) => {
      state.isAuthenticated = action.payload.isAuthenticated;
      state.token = action.payload.token;
      state.user = action.payload.user;
    },
  },
});

export const { setMode, setAuthState } = globalSlice.actions;
export const initializeAuth = () => (dispatch) => {
  const keycloak = getKeycloak();
  if (keycloak.authenticated) {
    dispatch(
      setAuthState({
        isAuthenticated: true,
        token: keycloak.token,
        user: keycloak.tokenParsed,
      })
    );
  }
};
export default globalSlice.reducer;
