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
import BaseMap from "./scenes/maps/base";
import Utilities from "./scenes/utilities";
import HomePage from "./scenes/home";
import PageNotFound from "./scenes/pagenotfound"
import Welcome from "./Welcome";
import RenderOnAnonymous from "./RenderOnAnonymous";
import RenderOnAuthenticated from "./RenderOnAuthenticated";
import NotRenderOnRole from "./NotRenderOnRole";
import Egis0 from "./scenes/egis0";

import { initializeAuth } from "./state"

import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import translationEN from "./locales/en/translation.json";
import translationKO from "./locales/ko/translation.json";
import translationLO from "./locales/lo/translation.json";



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


function App() {
  const mode = useSelector((state) => state.global.mode);
  const theme = useMemo(() => createTheme(themeSettings(mode)), [mode]);
  const dispatch = useDispatch();
  useEffect(() => {
    // Dispatch the action once when the component mounts
    dispatch(initializeAuth());
  }, [dispatch]);

  return (
    <div className="app">
      <BrowserRouter>
        <ThemeProvider theme={theme}>
          <CssBaseline />
          <RenderOnAnonymous>
            <Welcome />
          </RenderOnAnonymous>
          <RenderOnAuthenticated>
            <Routes>
              <Route path="/" element={<Navigate to="/home" />} />
              <Route path="/home" element={<HomePage />} />
              <Route path="/search" element={<BaseMap />} />
              <Route element={<Layout />}>
                <Route path="/dashboard" element={
                  <NotRenderOnRole roles={['egis-dev']} showNotAllowed>
                    <Dashboard />
                  </NotRenderOnRole>
                } />
                <Route path="/products" element={<Products />} />
                <Route path="/customers" element={
                  <NotRenderOnRole roles={['egis-dev']} showNotAllowed>
                    <Customers />
                  </NotRenderOnRole>
                } />
                <Route path="/tasks" element={<Utilities />} />
                <Route path="/transactions" element={<Transactions />} />

                <Route path="/montoring" element={
                  <NotRenderOnRole roles={[]} showNotAllowed>
                    <Egis0 />
                  </NotRenderOnRole>
                } />
              </Route>
              <Route path='*' element={<PageNotFound />} />
            </Routes>
          </RenderOnAuthenticated>
        </ThemeProvider>
      </BrowserRouter>
    </div>
  );
}
export default App;
