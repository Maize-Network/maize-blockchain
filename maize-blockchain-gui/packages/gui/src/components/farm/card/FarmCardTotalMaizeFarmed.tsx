import React, { useMemo } from 'react';
import { Trans } from '@lingui/macro';
import { useCurrencyCode, mojoToMaizeLocaleString, CardSimple, useLocale } from '@maize/core';
import { useGetFarmedAmountQuery } from '@maize/api-react';

export default function FarmCardTotalMaizeFarmed() {
  const currencyCode = useCurrencyCode();
  const [locale] = useLocale();
  const { data, isLoading, error } = useGetFarmedAmountQuery();

  const farmedAmount = data?.farmedAmount;

  const totalMaizeFarmed = useMemo(() => {
    if (farmedAmount !== undefined) {
      return (
        <>
          {mojoToMaizeLocaleString(farmedAmount, locale)}
          &nbsp;
          {currencyCode}
        </>
      );
    }
  }, [farmedAmount, locale, currencyCode]);

  return (
    <CardSimple
      title={<Trans>Total Maize Farmed</Trans>}
      value={totalMaizeFarmed}
      loading={isLoading}
      error={error}
    />
  );
}
