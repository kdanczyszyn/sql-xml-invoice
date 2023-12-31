CREATE VIEW [dbo].[RowsView]
AS
SELECT
    InvoiceNr = CONVERT(NVARCHAR(255), COALESCE(null, 'This is sample value for GitHub purposes'))
    CompanyCode =
    RowNumber =              -- Attribute
    RowType =                 -- Attribute
    RowPosition =            -- Attribute
    CostType =               -- Attribute
    BuyersPartNumber =     
    SellersPartNumber =     
    PartDescription =      
    DeliveryDate =          
    Quantity =              
    Unit =                 
    Each =                  
    Discount =             
    Price =                 
    RowSum =                
    BuyersOrderNumber =     
    SellersOrderNumber =    
    CountryOfOriginCode =   
    Setup =                 
FROM InvoiceHeader 
INNER JOIN InvoiceRows ON InvoiceHeader.CompanyCode = InvoiceRows.CompanyCode and InvoiceHeader.InvoiceNr = InvoiceRows.InvoiceNr
INNER JOIN OrderHeader on InvoiceHeader.OrderNr = OrderHeader.OrderNr and InvoiceHeader.CompanyCode = OrderHeader.CompanyCode
INNER JOIN Item on InvoiceRows.ArtNr = Item.ArtNr and InvoiceRows.CompanyCode = Item.CompanyCode
LEFT OUTER JOIN OrderRows on OrderHeader.OrderNr = OrderRows.OrderNr and OrderHeader.CompanyCode = OrderRows.CompanyCode and InvoiceRows.RowNumber = OrderRows.RowNumber
GO
