## Types of data loads
1. Full Load:

    Truncate and Load the data (Wipe existing data and load entire new data)
2. Upsert:

    Combination of update and insert (Update existing data and insert new data)
3. Incremental Load:

    Load only new data (usually done using datetime field)
4. Slowly changing dimentions

    - SCD1 - Update/overwrite changes
    - SCD2 - Addition of new row
    - SCD3 - Addition of new column

## Storage Layout Models
1. Row Store

    - Row-store / Row-Wise storage is horizontal partitioning.
    - This is suitable when you need to insert or update a record.
    - This model affects entire row where it scans through all the columns
    - Slower reads
    - Not optimized for querying.
    - Used in case of frequent transactions.
    - No efficient compression.

2. Column Store

    - Column-store model is vertical partitioning.
    - In this model values of same column are stored continuously.
    - In case where we need to extract specific column this model is preferred as it can easily extract those column/s without entire data, which makes it extremely performant.
    - Faster reads
    - Optimized for quering
    - Can't be used in case of frequent transactions.
    - Highly efficient compression

3. Hybrid Store

    Hybrid-store model combines both horizontal and vertical partitioning.

## Robin Round Distribution (Partitioning)

- Robin round distributes data evenly across partitions in a sequential way.
- It is fastest way to load a data in table/partition.
- Useful in case of staging.
- Not performant when using joins as data needs to be shuffled.

## Hash Partitioninig (Distribution)

- Hash distribution uses a hash function to decide to pre determine which partition the row/value is to be assigned.
- Hash function returns a value called as hash value which is derived by using a calculation.

## ACID Properties

### Transaction:

- In databases and data storage systems, a transaction in any operation which can be treated as single unit of work.
- A transaction either completes fully or doesn't complete at all, there can be only these 2 possibilities, it can't have any other state in between.

### Transaction example:

- Consider you transfer money from one account to another.
- When this transaction occurs the amount is debited from one account and credited to another, it can't be the case that it has debited from one account and not credited to other, this leads to imbalance.

#### Atomicity

- When unwanted situations like system failure, network issues or other arise it can lead to a problem when transaction is running, this could lead to incomplete execution.
- Atomicity ensures either the transaction is successful or in case of any failures it rollbacks the transaction, leaving the state intact as it was earlier.

#### Consistency

- A transaction should ensure consistency of data is maintained.
- It is to ensure no violations of business rules or conditions(constraints) are done.
- Classic example, you can withdraw only the amount available in your bank account, if you try to withdraw more, the account can go into negative balance which will not be allowed.
- Similarly, business can define set of rules to be applied in a database to ensure they are met and not compromised leading to any issues which can have severe consequences.

#### Isolation

- Multiple users are performing read and write operations on a same table at same time, this is called as concurrency.
- The isolation property makes sure every single transactions runs individually in isolation and doesn't interfere with other transactions.

#### Durability

- Durability ensures when transactions are executed the changes committed will be saved successfully.
- This means once a transaction is committed it will remain committed forever and that's a guarantee!

## Normalization

- Normalization in SQL is the process of organizing data in a database to reduce redundancy and improve data integrity.
- This process includes dividing the database or splitting the table into multiple tables and creating relationships between them to achieve consistency.

### 1NF

- Eliminate duplicate columns.
- Eliminate repeating groups in individual tables.
- Ensure all columns contain atomic(indivisible) values.
- Rows must be uniquely identifiable using primary key.

### 2NF

- Table should be in 1NF.
- Move the columns that are not depended on primary key to a new table.

### 3NF

### BCNF

