

import mysql.connector

mydb = mysql.connector.connect(
  host='lambda.cgo6g8slumka.eu-west-3.rds.amazonaws.com',
  user='admin',
  password='admin1994',
  database='proddatabase'
)

mycursor = mydb.cursor()

mycursor.execute("SELECT table_name FROM information_schema.tables")

myresult = mycursor.fetchall()

for x in myresult:
  print(x)
