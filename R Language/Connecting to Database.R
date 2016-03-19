#
# Connecting to Database : MySQL
# Author: galaa
# Created on 2016/03/19 07:49:41
#

# library dependence

library(RMySQL); # requires Java

# create connection

connection <- dbConnect(MySQL(),
  user = "root",
  password = "",
  host = "localhost"
);

# create new database

dbSendQuery(connection, "CREATE DATABASE r");

# attach database

dbSendQuery(connection, "USE r");

# create connection (database specific)

connection <- dbConnect(MySQL(),
  user = "root",
  password = "",
  host = "localhost",
  dbname = "r"
);

# remove existing table

dbSendQuery(connection, "
  DROP TABLE IF EXISTS children");

# create new table

dbSendQuery(connection, "
  CREATE TABLE children (
    id INT,
    name VARCHAR(50)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
);

# table list

dbListTables(connection);

# modify table structure

dbSendQuery(connection, "
  ALTER TABLE children
    CHANGE COLUMN id id INT
      AUTO_INCREMENT PRIMARY KEY,
    ADD COLUMN age INT UNSIGNED;
  "
);

# insert data

dbSendQuery(connection, "
  INSERT INTO children
    (name, age)
    VALUES
      ('Munkhmandakh',1),
      ('Munkh-Yargui',1);
  "
);

# id of last inserted row

last_id = fetch(dbSendQuery(connection,
  "SELECT LAST_INSERT_ID();"
));

# edit existing data

dbSendQuery(connection, "
  UPDATE children
    SET
      age=3
    WHERE
      name='Munkhmandakh'
  ;"
);

# load data

child = fetch(dbSendQuery(connection, "
  SELECT
    id, name, age
  FROM
    children
  WHERE
    age > 1
  ;"
));

# print data

print(child);

# connection list

dbListConnections(dbDriver(drv = "MySQL"));

# disconnect

dbDisconnect(connection); # specific connection
lapply(dbListConnections(dbDriver(drv = "MySQL")), dbDisconnect); # all
