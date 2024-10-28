import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";

export const egis0Api = createApi({
  baseQuery: fetchBaseQuery({ baseUrl: import.meta.env.VITE_REACT_EGIS0_API_BASE_URL }),
  reducerPath: "egis0Api",
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
        url: `update/${body._id}`,
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
} = egis0Api;
