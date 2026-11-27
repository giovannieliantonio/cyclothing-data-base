import psycopg2
import sys

con = None
con = psycopg2.connect(host='10.7.50.11',
                       database= 'cyclothing',
                       user= 'cyclothing_dev',
                       password= 'nMqst7a4')

cur = con.cursor()

# 2. Ejecutar la consulta para traer todo de la tabla "ropa"
cur.execute("SELECT * FROM cliente;")

# 3. Obtener todos los resultados e imprimirlos fila por fila
rows = cur.fetchall()
for row in rows:
    print(row)

# 4. Cerrar el cursor y la conexión
cur.close()
con.close()