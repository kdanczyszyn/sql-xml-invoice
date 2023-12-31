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
