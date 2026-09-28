## Pipeline

    A Pipeline controls the flow of tasks.
    Tasks are performed using activities.
    A pipeline can have one to many activities.
    These activities can be chained in serial or parallel depending on requirements.

## Activity

    Activities executes a task.
    Activities are broadly classified into three types.
        Data movement activities
        Data transformation activities
        Control activities
    Series, parallel and combination
    There is an activity for each task.
    Different activities include copy data, if, for each(loop), set variable, etc.

## Dataset

    Dataset is a pointer or reference to the application from where you need to extract or push the data.
    Depending on the service/application is has configurations which need to be set.
    When you create a dataset , ADF provides 90+ connectors which seamlessly help to connect to top services or applications.

## Linked Service

    Linked service establishes connection to a service or application from where you need to extract or push the data.
    This is an authentication entity which performs the handshake between the data factory and source/target service or application.
    Linked services are consumed in datasets

## Integration Runtime

    Integration Runtime a.k.a IR is the compute infrastructure needed to execute the pipelines in ADF.


# Copy Data Within Dataset

## Steps

- Create Pipeline
- Create Activities
- Create Dataset Source
- Create Linked Service
- Create Dataset Destination
- Validate
- Rename Activity
- Rename Pipeline
- Publish changes

# Copy Entire Folder

## Steps

- Create Pipeline
- Create Activities (Copy Data)
- Create Dataset Source
- Set dateset file path type to wildcard file path (mycontainer/Data/*)
- Reuse recent Dataset Destination
- Reuse Linked Service
- Validate
- Debug the pipeline
- Rename Activity
- Rename Pipeline
- Publish changes

# Copy Entire Folder with specific files

## Steps

- Create Pipeline
- Create Activities (Copy Data)
- Create Dataset Source
- Set dateset file path type to wildcard file path (mycontainer/Data/SALES*.*)
- Reuse recent Dataset Destination
- Reuse Linked Service
- Validate
- Debug the pipeline
- Rename Activity
- Rename Pipeline
- Publish changes

# Copy Entire Folder with specific files type

## Steps

- Create Pipeline
- Create Activities (Copy Data)
- Create Dataset Source
- Set dateset file path type to wildcard file path (mycontainer/Data/SALES*.csv)
- Reuse recent Dataset Destination
- Reuse Linked Service
- Validate
- Debug the pipeline
- Rename Activity
- Rename Pipeline
- Publish changes

# Copy data from ADLS to Azure SQL Database

## Steps

- Create pipeline
- Rename pipeline
- Create activity (copy data)
- Rename activity, add description
- Create dataset (source csv file)
- Reuse linked service for ADLS
- create dataset (sink)
- Create linked service for Azure SQL Database
- Set table option to autocreate in sink dataset
- Set schema and table name in open option of sink dataset
- Validate
- Debug
- Publish changes

# Copy data from Azure SQL Database to ADLS

## Steps

- Create pipeline
- Rename pipeline
- Create activity (copy data)
- Rename activity, add description
- Reuse dataset (source Azure SQL Database table)
- Reuse linked service for Azure SQL Database
- Reuse dataset (sink)
- Reuse linked service for ADLS
- Set file name to blank, orders.csv
- Validate
- Debug
- Debug again (Data in the file is overwritten)
- Publish changes

# Copy data from ADLS to Azure SQL Database

## Steps

- Create pipeline
- Rename pipeline
- Create activity (copy data)
- Rename activity, add description
- Create dataset (source csv file folder with wildcard file path *.csv(Files should have same format of data))
- Reuse linked service for ADLS
- create dataset (sink)
- Reuse linked service for Azure SQL Database
- Set table option to autocreate in sink dataset
- Set schema and table name in open option of sink dataset
- Select option to add column (Additional columns) and add column name and value as "FileName" and "$$FILENAME"
- Validate
- Debug
- Publish changes

# Set variable

## Steps

- Create pipeline
- Rename pipeline
- Add variable (to get variable menu click on empty place to add activity)
- Create activity (Set variable)

# Copy file in a timeframe

## Steps

- Create pipeline
- Rename pipeline
- Add activity copy data
- Add dataset source in folder with wildcard file path mycontainer/yearwise/*.csv
- Add criteria Filter by last modified Start time (UTC) as @subtractFromTime(utcNow(),1,'Hour') and End time (UTC) as @utcNow()
- Add sink dataset
- Validate
- Debug

# Get metadata activity

## Steps

- Create pipeline
- Rename pipeline
- Create Activity get metadata
- Add settings for the activity Dataset and Field list

# For Each activity

## Steps

- Create parameters (in blank portion click)
- Add activity foreach
- Add activity inside the foreach loop

# Copy each file from ADLS to new table in Azure SQL Database

## Steps

- Create pipeline
- Rename pipeline
- Create activity get metadata
- Create activity foreach
- Inside foreach create activity setvariable(filename=@item.name) and activity copy data
- Inside copy data activity create parameters filename for getting metadata filename value in current scope in both source and sink(Replace .csv with empty string for sink parameter)
- Create source dataset folder
- Create sink dataset Azure SQL Database
- Validate
- Debug

# Truncate and copy data from ADLS to Azure SQL Database

## Steps

- Create pipeline
- Rename pipeline
- Create activity copy data
- Create linked service
- Create dataset source from ADLS
- Create dataset sink to Azure SQL database
- Add sink Table option to Auto create table
- Add pre-copy script "TRUNCATE TABLE <schema_name>.<table_name>"

# Upsert from ADLS to Azure SQL Database

## Steps

- Clone previous pipeline
- In sink change Write behaviour to upsert from insert and remove pre-copy script
- Select key columns to unique key of the data
- Select table option to None

# Append variable activity

# Data copy using SQL Query

# Data copy with fewer columns and changed column names

## Steps

- Clone previous pipeline
- Create sink database in Azure SQL database using SQL
- Add existing database to sink dataset
- Change mapping in sink dataset
- Select columns to be kept in destination and map column as per the need

# Delete Activity

# Stored Procedure in copy activity (with returning data)

# Stored Procedure Activity (Does not return data)

# IF Activity

# Switch Activity

# Script Activity

# Validation Activity

# Convert CSV to JSON

# Convert JSON and Nested JSON to Azure SQL Database

# Execute Pipeline Activity

# Copy Data if File Exists

# Parameters and Variables

# Delete Blank Files

