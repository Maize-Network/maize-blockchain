import React from 'react';
import { SvgIcon, SvgIconProps } from '@mui/material';
import MaizeIcon from './images/maize_logo.svg';

export default function Keys(props: SvgIconProps) {
  return <SvgIcon component={MaizeIcon} viewBox="0 0 150 58" {...props} />;
}
