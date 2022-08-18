import React from 'react';
import styled from 'styled-components';
import { Box, BoxProps } from '@mui/material';
import { Maize } from '@maize/icons';

const StyledMaize = styled(Maize)`
  max-width: 100%;
  width: auto;
  height: auto;
`;

export default function Logo(props: BoxProps) {
  return (
    <Box {...props}>
      <StyledMaize />
    </Box>
  );
}
