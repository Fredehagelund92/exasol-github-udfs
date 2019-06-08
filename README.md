# exasol-github-udfs

## Overview

 ## Quick start


 1. Create Schema

Create a new schema eg. ETL_UDFS.

```
CREATE SCHEMA ETL_UDFS;
```


2. Install external libaries.

In order to use these udfs you will need to install following libaries:

-  [Requests (2.0 >)](https://pypi.python.org/pypi/requests/2.7.0)

If you do not know how to add a file to exabucket please visit following [guide](https://www.exasol.com/support/browse/SOL-503).

Remember to edit below path

```
glob.glob('/buckets/bfsdefault/default/requests-2.7.0/requests-2.7.0')
```



## Sources
### Assignees

```sql
insert into <table> select REST_SERVICES.GITHUB_ASSIGNEES('<accesstoken>', '<creator>', '<repository>')
```

It is also possible to retrieve multiple repositories.

Example:

```sql
Create table REST_SERVICES.REPOSITORIES (
CREATOR varchar(255),
REPO varchar(255)

);

insert into REST_SERVICES.REPOSITORIES (NAME) VALUES ('EXASOL','pyexasol'), ('EXASOL','database-migration');


select REST_SERVICES.GITHUB_ASSIGNEES('<accesstoken>', CREATOR, REPO) from REST_SERVICES.REPOSITORIES;

```