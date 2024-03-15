using { Currency, managed, sap } from '@sap/cds/common';

namespace sidi.play4sell;

entity FattureSD : managed {
  key ID      : Integer;
  quantita    : Integer;
}