import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import UserService from "./UserService";

export const egisApi = createApi({
  baseQuery: fetchBaseQuery({
    baseUrl: import.meta.env.VITE_EGIS_API_BASE_URL,
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
  reducerPath: "egisApi",
  tagTypes: [
    "Books",
  ],
  endpoints: (build) => ({
    getBook: build.query({
      query: (id) => `find/${id}`,
      providesTags: ["Books"],
    }),
    getBooks: build.query({
      query: () => "list",
      providesTags: ["Books"],
    }),
    addBook: build.mutation({
      query: (body) => ({
        url: 'create',
        method: 'POST',
        body: body,
      }),
      invalidatesTags: ['Books'],
    }),
    updateBook: build.mutation({
      query: (body) => ({
        url: `update/${body.id}`,
        method: 'PUT',
        body: body,
      }),
      invalidatesTags: ['Books'],
    }),
    deleteBook: build.mutation({
      query: (id) => ({
        url: `delete/${id}`,
        method: 'DELETE',
      }),
      invalidatesTags: ['Books'],
    }),
  }),
});

export const {
  useGetBookQuery,
  useGetBooksQuery,
  useAddBookMutation,
  useUpdateBookMutation,
  useDeleteBookMutation,
} = egisApi;
