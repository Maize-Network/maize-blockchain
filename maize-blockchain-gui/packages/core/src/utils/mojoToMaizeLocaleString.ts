import BigNumber from 'bignumber.js';
import Unit from '../constants/Unit';
import maizeFormatter from './maizeFormatter';

export default function mojoToMaizeLocaleString(mojo: string | number | BigNumber, locale?: string) {
  return maizeFormatter(mojo, Unit.MOJO)
    .to(Unit.MAIZE)
    .toLocaleString(locale);
}
