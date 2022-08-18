import BigNumber from 'bignumber.js';
import Unit from '../constants/Unit';
import maizeFormatter from './maizeFormatter';

export default function mojoToCATLocaleString(mojo: string | number | BigNumber, locale?: string) {
  return maizeFormatter(mojo, Unit.MOJO)
    .to(Unit.CAT)
    .toLocaleString(locale);
}
