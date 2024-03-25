using {sidi.play4sell as my} from '../db/schema';
using {API_BILLING_DOCUMENT_SRV as billing_document} from './external/API_BILLING_DOCUMENT_SRV';
using {OP_API_PRODUCT_SRV_0001 as api_products} from './external/OP_API_PRODUCT_SRV_0001';
using {API_MATERIAL_STOCK_SRV as api_products_stock} from './external/API_MATERIAL_STOCK_SRV';


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

  @readonly
  entity APIProducts as
    projection on api_products.A_Product {
      key Product,
      IsMarkedForDeletion,
      BaseUnit,
      to_ProductBasicText as basicTexts: redirected to APIProductBasicTexts,
      to_Description as descriptions: redirected to APIProductDescriptions,
      to_Valuation as valuations: redirected to APIProductValuations
    };

    @readonly
    entity APIProductValuations as
      projection on api_products.A_ProductValuation{
        key Product,
        key ValuationArea,
        key ValuationType,
        StandardPrice,
        Currency
      };

  @readonly
  entity APIProductStock as
    projection on api_products_stock.A_MatlStkInAcctMod {
      key Material,
      key Plant,
      key StorageLocation,
      key Batch,
      key Supplier,
      key Customer,
      key WBSElementInternalID,
      key SDDocument,
      key SDDocumentItem,
      key InventorySpecialStockType,
      key InventoryStockType,
      MatlWrhsStkQtyInMatlBaseUnit

    };

    @readonly
    entity APIProductBasicTexts as
      projection on api_products.A_ProductBasicText{
        key Product,
        key Language,
        LongText
      };
      
    @readonly
    entity APIProductDescriptions as
      projection on api_products.A_ProductDescription{
        key Product,
        key Language,
        ProductDescription
      };


  action jobFetchFattureSD() returns String;
  action testConnection() returns String;
  action jobFetchProducts() returns String;

  entity ListaProviggioniAgenti   as projection on ProviggioniAgenti;

  /** For display in details pages */
  @readonly
  entity ProviggioniAgenti        as
    projection on my.ProviggioniAgenti {
      *,

    };

    

  entity ListaNotaSpese as projection on NotaSpese;

  /** For display in details pages */
  
  entity NotaSpese as
    projection on my.NotaSpese {
      *,

    };

  
  entity ProductsList as projection on Products;

  /** For display in details pages */
  
  entity Products as
    projection on my.Products {
      *,

    };





};

