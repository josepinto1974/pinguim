import pymysql.cursors

try:
    connection = pymysql.connect(host='lambda.cgo6g8slumka.eu-west-3.rds.amazonaws.com',
                             user='admin',
                             password='admin1994',
                             database='proddatabase')

    sql_select_Query = "SELECT table_name FROM information_schema.tables"
    cursor = connection.cursor()
    cursor.execute(sql_select_Query)
    # get all records
    records = cursor.fetchall()
    print("Total number of rows in table: ", cursor.rowcount)

    print("\nPrinting each row")
    for row in records:
        print("Id = ", row[0], )
       

except mysql.connector.Error as e:
    print("Error reading data from MySQL table", e)
finally:
    if connection.is_connected():
        connection.close()
        cursor.close()
        print("MySQL connection is closed")