import BigNumber from 'bignumber.js';
import Unit from '../constants/Unit';
import maizeFormatter from './maizeFormatter';

export default function mojoToMaize(mojo: string | number | BigNumber): BigNumber {
  return maizeFormatter(mojo, Unit.MOJO)
    .to(Unit.MAIZE)
    .toBigNumber();
}