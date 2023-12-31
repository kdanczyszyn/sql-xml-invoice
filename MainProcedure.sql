
-- =============================================
-- Author:		KamDan (Kamil Dańczyszyn)
-- Description:	Generate XML Invoice 
-- declare @xml nvarchar(500); EXEC [dbo].[MainProcedure] 1117859, 1190, @xml out; select @xml 
-- =============================================
ALTER PROCEDURE [dbo].[MainProcedure]
	-- Add the parameters for the stored procedure here
	@InvoiceNr bigint = NULL, 
	@CompanyCode smallint = 0,
  @XmlPath NVARCHAR(500) OUT
AS
BEGIN

    -- Declaration
    DECLARE @SoftwareManufacturer NVARCHAR(255) = 'SampleData';
    DECLARE @SoftwareName NVARCHAR(255) = 'foo';
    DECLARE @SoftwareVersion NVARCHAR(255) = '1.1.1';
    DECLARE @InvoiceNumber INT = @InvoiceNr;
    DECLARE @InvoiceType INT = 1;
    DECLARE @XmlData XML;
    DECLARE @XmlDataHead XML;
    DECLARE @xmlDataRows XML;

    -- Collect data
    -- <Head>
    EXEC [dbo].[HeaderProcedure] @invoicenr, @CompanyCode, @XmlData = @XmlDataHead OUTPUT

    -- <Rows>
    EXEC [dbo].[RowsProcedure] @invoicenr, @CompanyCode, @XmlData = @xmlDataRows OUTPUT

    -----------------------------
    -- Create full XML Message --
    -----------------------------
    SET @XmlData = (
        SELECT
        @SoftwareManufacturer as '@SoftwareManufacturer',
        @SoftwareName as '@SoftwareName',
        @SoftwareVersion as '@SoftwareVersion',
        (
            SELECT @InvoiceNr as '@InvoiceNumber',
                   @InvoiceType as '@InvoiceType'
            FOR XML PATH('Invoice'), TYPE
        ),
        (
            SELECT @XmlDataHead
        ),
        (
            SELECT @xmlDataRows
        )
        FOR XML PATH('INVOIC416'), TYPE
    )

    
    -----------------
    -- File output --
    -----------------

    -- Declaration
    CREATE TABLE ##TempTable (XmlData XML);
    INSERT INTO ##TempTable (XmlData)
    SELECT @XmlData as XmlData

    DECLARE @path nvarchar(255)      
    DECLARE @XmlTxt nvarchar(max)
    DECLARE @MessageStr nvarchar(max)
 
    EXEC [dbo].[someProcedureToGetConfiguration] 'XML Invoices path', @path OUT;

    SELECT @path = @path + 'Invoice' + '_' + CAST(@CompanyCode as nvarchar) + '_' + CAST(@InvoiceNr as nvarchar) + '.xml'

    SELECT @XmlTxt = convert(nvarchar(max), @XmlData)

    EXEC [dbo].[FileManagerDelete] @path -- delete old
    EXEC [dbo].[FileManagerAppend] @path, @XmlTxt, @MessageStr OUT -- export file
    -- Param output
    SELECT @XmlPath = @path

    DROP TABLE ##TempTable

END



