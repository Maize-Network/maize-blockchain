import { WalletType } from '@maize/api';
import type { Wallet } from '@maize/api';

export default function getWalletPrimaryTitle(wallet: Wallet): string {
  switch (wallet.type) {
    case WalletType.STANDARD_WALLET:
      return 'Maize';
    default:
      return wallet.name;
  }
}
