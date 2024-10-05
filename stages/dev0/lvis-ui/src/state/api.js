import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";

export const api = createApi({
  baseQuery: fetchBaseQuery({ baseUrl: import.meta.env.VITE_REACT_APP_BASE_URL }),
  reducerPath: "adminApi",
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
    getCustomer: build.query({
      query: (id) => `client/customers/${id}`,
      providesTags: ["Customers"],
    }),    
    getCustomers: build.query({
      query: ({ page, pageSize, sort, search }) => ({
        url: "client/customers",
        method: "GET",
        params: { page, pageSize, sort, search },        
      }),
      providesTags: ["Customers"],
    }),
    // addCustomer: build.query({
    //   query: (body) => ({
    //     url: "client/customers",
    //     method: 'POST',
    //     body,
    //   }),
    //   invalidatesTags: ['Customers'],
    // }),    
    // updateCustomer: build.query({
    //   query: (body) => ({
    //     url: `client/customers`,
    //     method: 'PATCH',
    //     body,
    //   }),
    //   invalidatesTags: ['Customers'],
    // }),      
    // deleteCustomer: build.query({
    //   query(id) {
    //     return {
    //       url: `client/customers/${id}`,
    //       method: 'DELETE',
    //     }
    //   },
    //   invalidatesTags: ['Customers'],
    // }),    
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
  // useAddCustomerQuery,
  // useUpdateCustomerQuery,
  // useDeleteCustomerQuery,
  useAddCustomerMutation,
  useUpdateCustomerMutation,
  useDeleteCustomerMutation,  
  useGetTransactionsQuery,
  useGetGeographyQuery,
  useGetSalesQuery,
  useGetAdminsQuery,
  useGetUserPerformanceQuery,
  useGetDashboardQuery,
} = api;
