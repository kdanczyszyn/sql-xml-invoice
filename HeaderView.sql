CREATE VIEW [dbo].[HeaderView]
AS
    SELECT DISTINCT
    InvoiceNr =                         
    CompanyCode =                        
    SellersOrderNumber =                
    OrderDate =                         
    BuyersOrderNumber =                 
    DebitInvoiceNumber =                
    InvoiceDate =                       
    LanguageNameCode =                  
    ReferenceNumber =                   

    /* -- Buyer -- */
    BuyerCode =                        
    BuyerName =                         
    BuyerVATRegistrationNumber =       
    BuyerReference =                    

    /* -- InvoiceAddress -- */
    InvoiceAddressName =               
    InvoiceAddressStreetBox1 =         
    InvoiceAddressStreetBox2 =         
    InvoiceAddressZipCity1 =            
    InvoiceAddressZipCity2 =            
    InvoiceAddressCountry =            

    /* -- DeliveryAddress -- */
    DeliveryAddressName =              
    DeliveryAddressStreetBox1 =         
    DeliveryAddressStreetBox2 =         
    DeliveryAddressZipCity1 =           
    DeliveryAddressZipCity2 =           
    DeliveryAddressCountry =            
/*
  other fields
*/  
FROM [dbo].[InvoiceHeader]
LEFT OUTER JOIN [dbo].[InvoiceRows] ON [dbo].[InvoiceHeader].[InvoiceNr] = [dbo].[InvoiceRows].[InvoiceNr]
        AND [dbo].[InvoiceHeader].[CompanyCode] = [dbo].[InvoiceRows].[CompanyCode]
/*
  and other joins
*/
GO





