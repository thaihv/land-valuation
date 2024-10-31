import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import UserService from "./UserService";

export const prototypeApi = createApi({
  baseQuery: fetchBaseQuery({ baseUrl: import.meta.env.VITE_PROTOTYPE_API_BASE_URL, 
    prepareHeaders: (headers) => {
      const cb = () => {
        // Retrieve token from Redux state or local storage
        if (UserService.isLoggedIn()) {
          const token = UserService.getToken() || localStorage.getItem('token');
          // If we have a token, set the `Authorization` header
          if (token) {
            headers.set('Authorization', `Bearer ${token}`);
          }
        }
        return headers;
      }
      return UserService.updateToken(cb);
    },
  }),
  reducerPath: "prototypeApi",
  tagTypes: [
    "User",
    "Products",
    "Customers",
    "Transactions",
    "Geography",
    "Sales",
    "Admins",
    "Performance",
    "Dashboard",
  ],
  endpoints: (build) => ({
    getUser: build.query({
      query: (id) => `general/user/${id}`,
      providesTags: ["User"],
    }),
    getProducts: build.query({
      query: () => "client/products",
      providesTags: ["Products"],
    }),  
    getCustomers: build.query({
      query: ({ page, pageSize, sort, search }) => ({
        url: "client/customers",
        method: "GET",
        params: { page, pageSize, sort, search },        
      }),
      providesTags: ["Customers"],
    }),    
    getCustomer: build.query({
      query: (id) => `client/customers/${id}`,
      providesTags: ["Customers"],
    }),      
    addCustomer: build.mutation({
      query: (body) => ({
        url: 'client/customers',
        method: 'POST',
        body: body,
      }),
      invalidatesTags: ['Customers'],
    }),
    updateCustomer: build.mutation({
      query: (body) => ({
        url: `client/customers/${body._id}`,
        method: 'PUT',
        body: body,
      }),
      invalidatesTags: ['Customers'],
    }),
    deleteCustomer: build.mutation({
      query: (id) => ({
        url: `client/customers/${id}`,
        method: 'DELETE',
      }),
      invalidatesTags: ['Customers'],
    }),

    getTransactions: build.query({
      query: ({ page, pageSize, sort, search }) => ({
        url: "client/transactions",
        method: "GET",
        params: { page, pageSize, sort, search },
      }),
      providesTags: ["Transactions"],
    }),
    getGeography: build.query({
      query: () => "client/geography",
      providesTags: ["Geography"],
    }),
    getSales: build.query({
      query: () => "sales/sales",
      providesTags: ["Sales"],
    }),
    getAdmins: build.query({
      query: () => "management/admins",
      providesTags: ["Admins"],
    }),
    getUserPerformance: build.query({
      query: (id) => `management/performance/${id}`,
      providesTags: ["Performance"],
    }),
    getDashboard: build.query({
      query: () => "general/dashboard",
      providesTags: ["Dashboard"],
    }),
  }),
});

export const {
  useGetUserQuery,
  useGetProductsQuery,
  useGetCustomerQuery,
  useGetCustomersQuery,
  useAddCustomerMutation,
  useUpdateCustomerMutation,
  useDeleteCustomerMutation,  
  useGetTransactionsQuery,
  useGetGeographyQuery,
  useGetSalesQuery,
  useGetAdminsQuery,
  useGetUserPerformanceQuery,
  useGetDashboardQuery,
} = prototypeApi;
