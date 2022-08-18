import BigNumber from 'bignumber.js';
import Unit from '../constants/Unit';
import maizeFormatter from './maizeFormatter';

export default function maizeToMojo(maize: string | number | BigNumber): BigNumber {
  return maizeFormatter(maize, Unit.MAIZE)
    .to(Unit.MOJO)
    .toBigNumber();
}