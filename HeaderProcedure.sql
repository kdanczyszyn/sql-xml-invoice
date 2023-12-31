-- =============================================
-- Author:		KamDan (Kamil Dańczyszyn)
-- Description:	Generate XML Invoice Header
-- declare @xml xml; exec [dbo].[HeaderProcedure] 1117859, 1190, @xml out; select @xml
-- exec [dbo].[HeaderProcedure] 1117859, 1190
-- =============================================
ALTER PROCEDURE [dbo].[HeaderProcedure]
	-- Add the parameters for the stored procedure here
	@InvoiceNr bigint = NULL, 
	@CompanyCode smallint = 0,
    @XmlData XML OUTPUT
AS
BEGIN

SET @XmlData = 
(
SELECT [H].SellersOrderNumber AS 'SellersOrderNumber',
             [H].OrderDate AS 'OrderDate',
             [H].BuyersOrderNumber AS 'BuyersOrderNumber',
             [H].DebitInvoiceNumber AS 'DebitInvoiceNumber',
             [H].InvoiceDate AS 'InvoiceDate',
             [H].LanguageNameCode AS 'LanguageNameCode',
             (
                 SELECT
                     [H].ReferenceNumber AS 'ReferenceNumber',
                     [H].BuyerCode AS 'BuyerCode',
                     [H].BuyerName AS 'BuyerName',
                     [H].BuyerVATRegistrationNumber AS 'BuyerVATRegistrationNumber',
                     [H].BuyerReference AS 'BuyerReference',
                     (
                        SELECT
                        [H].InvoiceAddressName AS 'InvoiceAddressName',
                        [H].InvoiceAddressStreetBox1 AS 'InvoiceAddressStreetBox1',
                        [H].InvoiceAddressStreetBox2 AS 'InvoiceAddressStreetBox2',
                        [H].InvoiceAddressZipCity1 AS 'InvoiceAddressZipCity1',
                        [H].InvoiceAddressZipCity2 AS 'InvoiceAddressZipCity2',
                        [H].InvoiceAddressCountry AS 'InvoiceAddressCountry'
                        FOR XML PATH('InvoiceAddress'), TYPE                             
                     ),
                     (
                        SELECT
                        [H].DeliveryAddressName AS 'DeliveryAddressName',
                        [H].DeliveryAddressStreetBox1 AS 'DeliveryAddressStreetBox1',
                        [H].DeliveryAddressStreetBox2 AS 'DeliveryAddressStreetBox2',
                        [H].DeliveryAddressZipCity1 AS 'DeliveryAddressZipCity1',
                        [H].DeliveryAddressZipCity2 AS 'DeliveryAddressZipCity2',
                        [H].DeliveryAddressCountry AS 'DeliveryAddressCountry'
                        FOR XML PATH('DeliveryAddress'), TYPE
                     )
                 FOR XML PATH('Buyer'), TYPE
				 -- code was edited for github purposes to not include every column used in this code
				 -- so there might be some syntax errors
             )	
from [dbo].[HeaderView] as [H]
where InvoiceNr = @InvoiceNr and CompanyCode = @CompanyCode   
FOR XML PATH('Head'), TYPE 
)

SELECT @XmlData

END


