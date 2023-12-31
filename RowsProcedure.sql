-- =======================================
-- Author:		KamDan (Kamil Dańczyszyn)
-- Description:	Generate XML Invoice Rows 
-- exec [RowsProcedure] 1112828, 1190
-- =======================================
ALTER PROCEDURE [dbo].[RowsProcedure]
	@invoicenr bigint,
    @CompanyCode smallint,
    @XmlData XML OUTPUT
AS
BEGIN

    DECLARE @RowNumber NVARCHAR(255)          
    DECLARE @RowType NVARCHAR(255)            
    DECLARE @RowPosition NVARCHAR(255)        
    DECLARE @CostType NVARCHAR(255)           
    DECLARE @BuyersPartNumber NVARCHAR(255)   
    DECLARE @SellersPartNumber NVARCHAR(255)  
    DECLARE @PartDescription NVARCHAR(255)    
    DECLARE @DeliveryDate NVARCHAR(255)       
    DECLARE @Quantity NVARCHAR(255)           
    DECLARE @Unit NVARCHAR(255)               
    DECLARE @Each NVARCHAR(255)               
    DECLARE @Discount NVARCHAR(255)           
    DECLARE @Price NVARCHAR(255)              
    DECLARE @RowSum NVARCHAR(255)             
    DECLARE @BuyersOrderNumber NVARCHAR(255)  
    DECLARE @SellersOrderNumber NVARCHAR(255) 
    DECLARE @CountryOfOriginCode NVARCHAR(255)
    DECLARE @Setup NVARCHAR(255)    
    DECLARE @XmlDataRows XML

    DECLARE rows CURSOR FAST_FORWARD READ_ONLY FOR
    SELECT 
        RowNumber,         
        RowType,           
        RowPosition,       
        CostType,           
        BuyersPartNumber,  
        SellersPartNumber, 
        PartDescription, 
        DeliveryDate,       
        Quantity,         
        Unit,              
        Each,              
        Discount,          
        Price,              
        RowSum,            
        BuyersOrderNumber, 
        SellersOrderNumber, 
        CountryOfOriginCode,
        Setup
    FROM RowsView
    WHERE InvoiceNr = @invoicenr and CompanyCode = @CompanyCode

    OPEN rows
    WHILE 1=1
    BEGIN
        FETCH NEXT FROM rows INTO
                            @RowNumber,         
                            @RowType,           
                            @RowPosition,       
                            @CostType,          
                            @BuyersPartNumber,  
                            @SellersPartNumber, 
                            @PartDescription, 
                            @DeliveryDate,      
                            @Quantity,         
                            @Unit,              
                            @Each,              
                            @Discount,          
                            @Price,             
                            @RowSum,            
                            @BuyersOrderNumber, 
                            @SellersOrderNumber,
                            @CountryOfOriginCode,
                            @Setup

        IF @@FETCH_STATUS < 0 BREAK;

        Set @XmlDataRows = (
            SELECT @XmlDataRows, (
                SELECT
                    @RowNumber as '@RowNumber',
                    @RowType as '@RowType',
                    @RowPosition as '@RowPosition',
                    @CostType as '@CostType',
                    @BuyersPartNumber as 'BuyersPartNumber',
                    @SellersPartNumber as 'SellersPartNumber',
                    @PartDescription as 'PartDescription',
                    @DeliveryDate as 'DeliveryDate',
                    @Quantity as 'Quantity',
                    @Unit as 'Unit',
                    @Each as 'Each',
                    @Discount as 'Discount',
                    @Price as 'Price',
                    @RowSum as 'RowSum',
                    @BuyersOrderNumber as 'BuyersOrderNumber',
                    @SellersOrderNumber as 'SellersOrderNumber',
                    @CountryOfOriginCode as 'CountryOfOriginCode',
                    @Setup as 'Setup'
                FOR XML PATH('Row'), TYPE )
            FOR XML PATH(''), TYPE
        )
    END
    CLOSE rows
    DEALLOCATE rows

    SET @xmlData = (SELECT @XmlDataRows FOR XML PATH('Rows'), TYPE)
END



