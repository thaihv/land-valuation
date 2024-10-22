import { CssBaseline, ThemeProvider } from "@mui/material";
import { createTheme } from "@mui/material/styles";
import { useMemo, useEffect } from "react";
import { useSelector, useDispatch } from "react-redux";
import { BrowserRouter, Navigate, Route, Routes } from "react-router-dom";
import { themeSettings } from "./theme";
import Layout from "./scenes/layout";
import Dashboard from "./scenes/dashboard";
import Products from "./scenes/products";
import Customers from "./scenes/customers";
import Transactions from "./scenes/transactions";
import Geography from "./scenes/charts/geography";
import Overview from "./scenes/charts/overview";
import Daily from "./scenes/charts/daily";
import Monthly from "./scenes/charts/monthly";
import Breakdown from "./scenes/charts/breakdown";
import Admin from "./scenes/admin";
import Performance from "./scenes/performance";
import BaseMap from "./scenes/maps/base";
import SurveyMap from "./scenes/maps/survey";
import Calendar from "./scenes/calendar";
import Team from "./scenes/team";
import Profile from "./scenes/profile";
import Utilities from "./scenes/utilities";
import HomePage from "./scenes/home";
import PageNotFound from "./scenes/pagenotfound"

import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import translationEN from "./locales/en/translation.json";
import translationKO from "./locales/ko/translation.json";
import translationLO from "./locales/lo/translation.json";

import UserService from "./state/UserService";
import { initializeAuth } from './state';

const resources = {
  en: {
    translation: translationEN,
  },
  ko: {
    translation: translationKO,
  },
  lo: {
    translation: translationLO,
  },
};

i18n.use(initReactI18next).init({
  resources,
  lng: "en",
  fallbackLng: "en",
  interpolation: {
    escapeValue: false,
  },
});

const ProtectedRoute = ({ children }) => {
  const isAuthenticated = useSelector((state) => state.global.isAuthenticated);
  return isAuthenticated ? children : <Navigate to="/" />;
};

function App() {
  const mode = useSelector((state) => state.global.mode);
  const theme = useMemo(() => createTheme(themeSettings(mode)), [mode]);
  const isAuth = Boolean(useSelector((state) => state.global.isAuthenticated));

  const dispatch = useDispatch();
  useEffect(() => {
    // Initialize Keycloak once when the component mounts
    UserService.initKeycloak(() => {
      dispatch(initializeAuth());
    });
  }, [dispatch]);

  return (
    <div className="app">
      <BrowserRouter>
        <ThemeProvider theme={theme}>
          <CssBaseline />
          <Routes>
            <Route path="/" element={isAuth ? <Navigate to="/home" /> : <Navigate to="/" />} />
            <Route path="/home" element={isAuth ? <HomePage /> : <Navigate to="/" />} />
            <Route path="/profile/:id" element={isAuth ? <Profile /> : <Navigate to="/" />} />
            <Route path="/search" element={isAuth ? <BaseMap /> : <Navigate to="/" />} />

            <Route element={<Layout />}>
              <Route path="/dashboard" element={isAuth ? <Dashboard /> : <Navigate to="/" />} />
              <Route path="/products" element={isAuth ? <Products /> : <Navigate to="/" />} />
              <Route path="/customers" element={isAuth ? <Customers /> : <Navigate to="/" />} />
              <Route path="/survey" element={isAuth ? <SurveyMap /> : <Navigate to="/" />} />
              <Route path="/myteam" element={isAuth ? <Team /> : <Navigate to="/" />} />
              <Route path="/calendar" element={
                <ProtectedRoute>
                  <Calendar />
                </ProtectedRoute>}
              />
              <Route path="/tasks" element={isAuth ? <Utilities /> : <Navigate to="/" />} />
              <Route path="/transactions" element={isAuth ? <Transactions /> : <Navigate to="/" />} />
              <Route path="/geography" element={isAuth ? <Geography /> : <Navigate to="/" />} />
              <Route path="/overview" element={isAuth ? <Overview /> : <Navigate to="/" />} />
              <Route path="/daily" element={isAuth ? <Daily /> : <Navigate to="/" />} />
              <Route path="/monthly" element={isAuth ? <Monthly /> : <Navigate to="/" />} />
              <Route path="/breakdown" element={isAuth ? <Breakdown /> : <Navigate to="/" />} />
              <Route path="/admin" element={isAuth ? <Admin /> : <Navigate to="/" />} />
              <Route path="/performance" element={isAuth ? <Performance /> : <Navigate to="/" />} />
            </Route>
            <Route path='*' element={<PageNotFound />} />

          </Routes>
        </ThemeProvider>
      </BrowserRouter>
    </div>
  );
}

export default App;
