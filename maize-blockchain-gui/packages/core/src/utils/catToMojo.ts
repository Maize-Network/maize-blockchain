import BigNumber from 'bignumber.js';
import Unit from '../constants/Unit';
import maizeFormatter from './maizeFormatter';

export default function catToMojo(cat: string | number | BigNumber): BigNumber {
  return maizeFormatter(cat, Unit.CAT)
    .to(Unit.MOJO)
    .toBigNumber();
}