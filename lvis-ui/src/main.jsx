import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";

import App from "./App";
import { configureStore } from "@reduxjs/toolkit";
import globalReducer from "./state";
import { Provider } from "react-redux";
import { setupListeners } from "@reduxjs/toolkit/query";
import { api } from "./state/api";
import {I18nextProvider} from "react-i18next";
import i18next from "i18next";

const store = configureStore({
  reducer: {
    global: globalReducer,
    [api.reducerPath]: api.reducer,
  },
  middleware: (getDefault) => getDefault().concat(api.middleware),
});
setupListeners(store.dispatch);

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <Provider store={store}>
      <I18nextProvider i18n={i18next}>
        <App/>
      </I18nextProvider>
    </Provider>
  </React.StrictMode>
);