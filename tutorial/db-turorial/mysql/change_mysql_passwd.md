# mysql57

service mysql stop

mysqld_safe --skip-grant-tables &

mysql -p

update mysql.user set authentication_string=password('anwg123.') where user='root' and Host ='localhost';
