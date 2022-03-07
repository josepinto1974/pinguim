
import pymysql.cursors

connection = pymysql.connect(host='lambda.cgo6g8slumka.eu-west-3.rds.amazonaws.com',
                             user='admin',
                             password='admin1994',
                             database='proddatabase')


def lambda_handler(event, context):
    cursor = connection.cursor()
    cursor.execute('select * from MyGuests')   
    rows = cursor.fetchall()
    for row in rows:
         print("{0}".format(row[0]))


    handler()

