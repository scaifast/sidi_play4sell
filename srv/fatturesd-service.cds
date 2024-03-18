using {sidi.play4sell as my} from '../db/schema';
using {API_BILLING_DOCUMENT_SRV as billing_document} from './external/API_BILLING_DOCUMENT_SRV';


service CatalogService @(path: '/browse') {

  /** For displaying lists of Books */
  @readonly
  entity ListaFattureSD   as projection on FattureSD;

  /** For display in details pages */
  @readonly
  entity FattureSD        as
    projection on my.FattureSD {
      *,

    };



 @readonly
  entity BillingDocuments as
    projection on billing_document.A_BillingDocument {
      key BillingDocument,
          SDDocumentCategory,
          BillingDocumentType,
          CreationDate
    };

  action jobFetchFattureSD() returns String;
  action testConnection() returns String;

  entity ListaProviggioniAgenti   as projection on ProviggioniAgenti;

  /** For display in details pages */
  @readonly
  entity ProviggioniAgenti        as
    projection on my.ProviggioniAgenti {
      *,

    };

    
};

