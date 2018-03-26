#!/bin/sh

# Default value for the MySQL port
if [ -z "$MYSQL_PORT" ]
then
    MYSQL_PORT=3306
fi

# Default value for the MySQL address
if [ -z "$MYSQL_ADDRESS" ]
then
    MYSQL_ADDRESS=localhost
fi

# Loop to wait for a successful connection
# Change the time between retries as desired (seconds)
while ! nc -z "$MYSQL_ADDRESS" "$MYSQL_PORT" >/dev/null 2>&1
do
    sleep 3;
done

echo "The MySQL server is running"

exit
