import psycopg2
import sys

con = None
con = psycopg2.connect(host='10.7.50.11',
                       database= 'cyclothing',
                       user= 'cyclothing',
                       password= 'Amffst+9')

print("hola")
con.close()


