import { useGetNFTsByNFTIDsQuery } from '@maize/api-react';
import { useLocalStorage } from '@maize/core';

export default function useNachoNFTs() {
  const [nachoNFTsString] = useLocalStorage('nachoNFTs', '');
  const nachoNFTIDs = nachoNFTsString
    .split(',')
    .map((nachoNFT: string) => nachoNFT.trim());

  return useGetNFTsByNFTIDsQuery(
    { nftIds: nachoNFTIDs },
    { skip: !nachoNFTsString || nachoNFTIDs.length === 0 },
  );
}
