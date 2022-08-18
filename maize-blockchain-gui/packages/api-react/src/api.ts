import { createApi } from '@reduxjs/toolkit/query/react';
import maizeLazyBaseQuery from './maizeLazyBaseQuery';

export const baseQuery = maizeLazyBaseQuery({});

export default createApi({
  reducerPath: 'maizeApi',
  baseQuery,
  endpoints: () => ({}),
});
