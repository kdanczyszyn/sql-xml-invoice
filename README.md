# sql-xml-invoice
Create XML message of invoice send to external customer. Code is real life example from application used in big logistic company I currently work for.

Of course the code is slightly modified to not leak any sensitive data.

## Overview
### Files used:
- HeaderView.sql
- RowsView.sql
- HeaderProcedure.sql
- RowsProcedure.sql
- MainProcedure.sql

### Flow
When action is triggered, the MainProcedure.sql is executed and full XML message is created.
The first step is to collect data from two other procedures, HeaderProcedure and RowsProcedure with output parameters. 
Output is saved in two variables used later to generate XML message.
Data from both segments is dynamicly generated based on data selected from HeaderView and RowsView.
After the full XML is created, message is saved on external drive to be processed.

### Full XML
some of fields are not included, this is just overview with fake data
><INVOIC416 SoftwareManufacturer="SampleGitHub" SoftwareName="foo" SoftwareVersion="1.1.1">
	<Invoice InvoiceNumber="123123131" InvoiceType="1"/>
	<Head>
		<SellersOrderNumber>122368</SellersOrderNumber>
		<OrderDate>1999-01-01</OrderDate>
		<BuyersOrderNumber>52004</BuyersOrderNumber>
		<DebitInvoiceNumber/>
		<InvoiceDate>1999-01-01</InvoiceDate>
		<LanguageNameCode>EN</LanguageNameCode>
		<Buyer>
			<ReferenceNumber>52004</ReferenceNumber>
			<BuyerCode>1033</BuyerCode>
			<BuyerName>GitHub</BuyerName>
			<BuyerVATRegistrationNumber>123123</BuyerVATRegistrationNumber>
			<BuyerReference/>
			<InvoiceAddress>
				<InvoiceAddressName>GitHub</InvoiceAddressName>
				<InvoiceAddressStreetBox1>GitHub</InvoiceAddressStreetBox1>
				<InvoiceAddressStreetBox2/>
				<InvoiceAddressZipCity1>some data</InvoiceAddressZipCity1>
				<InvoiceAddressZipCity2/>
				<InvoiceAddressCountry>Europe</InvoiceAddressCountry>
			</InvoiceAddress>
			<DeliveryAddress>
				<DeliveryAddressName>GitHub</DeliveryAddressName>
				<DeliveryAddressStreetBox1>GitHub</DeliveryAddressStreetBox1>
				<DeliveryAddressStreetBox2/>
				<DeliveryAddressZipCity1>some data</DeliveryAddressZipCity1>
				<DeliveryAddressZipCity2/>
				<DeliveryAddressCountry>Europe</DeliveryAddressCountry>
			</DeliveryAddress>
		</Buyer>
		<Seller>
			<SellerSuplierCode>1190</SellerSuplierCode>
			<SellerName>Kamil Danczyszyn</SellerName>
			<SellerReference>NEW PROJECT</SellerReference>
			<SellerReferencePhone/>
			<SellerReferenceFax/>
			<SellerReferenceEmail/>
			<SellerOrigin></SellerOrigin>
			<SellerWeb></SellerWeb>
			<SellerPhone></SellerPhone>
			<SellerRegistrationNumber></SellerRegistrationNumber>
			<SellerVATRegistrationNumber></SellerVATRegistrationNumber>
			<PostalAddress>
				<PostalAddressStreetBox1></PostalAddressStreetBox1>
				<PostalAddressStreetBox2/>
				<PostalAddressZipCity1></PostalAddressZipCity1>
				<PostalAddressZipCity2/>
				<PostalAddressCountry></PostalAddressCountry>
			</PostalAddress>
			<VisitingAddress>
				<VisitingAddressStreetBox1></VisitingAddressStreetBox1>
				<VisitingAddressStreetBox2/>
				<VisitingAddressZipCity1></VisitingAddressZipCity1>
				<VisitingAddressZipCity2/>
				<VisitingAddressCountry></VisitingAddressCountry>
			</VisitingAddress>
		</Seller>  -- and some other fields
	</Head>
	<Rows>
		<Row RowNumber="1" RowType="1" RowPosition="10" CostType="0">
			<BuyersPartNumber></BuyersPartNumber>
			<SellersPartNumber></SellersPartNumber>
			<PartDescription></PartDescription>
			<DeliveryDate></DeliveryDate>
			<Quantity>2000.00</Quantity>
			<Unit>pcs</Unit>
			<Each/>
			<Discount>0.00</Discount>
			<Price>4.40</Price>
			<RowSum>8800.00</RowSum>
			<BuyersOrderNumber></BuyersOrderNumber>
			<SellersOrderNumber></SellersOrderNumber>
			<CountryOfOriginCode></CountryOfOriginCode>
			<Setup/>
		</Row>
		<Row RowNumber="2" RowType="1" RowPosition="20" CostType="0">
			<BuyersPartNumber></BuyersPartNumber>
			<SellersPartNumber></SellersPartNumber>
			<PartDescription></PartDescription>
			<DeliveryDate></DeliveryDate>
			<Quantity></Quantity>
			<Unit></Unit>
			<Each/>
			<Discount></Discount>
			<Price></Price>
			<RowSum></RowSum>
			<BuyersOrderNumber></BuyersOrderNumber>
			<SellersOrderNumber></SellersOrderNumber>
			<CountryOfOriginCode></CountryOfOriginCode>
			<Setup/>
		</Row>
		<Row RowNumber="3" RowType="1" RowPosition="30" CostType="0">
			<BuyersPartNumber/>
			<SellersPartNumber></SellersPartNumber>
			<PartDescription></PartDescription>
			<DeliveryDate></DeliveryDate>
			<Quantity></Quantity>
			<Each/>
			<Discount></Discount>
			<Price></Price>
			<RowSum></RowSum>
			<BuyersOrderNumber></BuyersOrderNumber>
			<SellersOrderNumber></SellersOrderNumber>
			<CountryOfOriginCode/>
			<Setup/>
		</Row>
	</Rows>
</INVOIC416>



