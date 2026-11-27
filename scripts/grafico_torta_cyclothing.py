import psycopg2
import sys
import pandas as pd
import matplotlib.pyplot as plt
con = None
con = psycopg2.connect(host='10.7.50.11',
                       database= 'cyclothing',
                       user= 'cyclothing_dev',
                       password= 'nMqst7a4')

# 2. Consulta del Top 5 tipos de ropa por monto vendido
query_torta = """
SELECT
    tr.nombre_tipo AS producto,
    SUM(dp.precio_venta) AS subtotal
FROM detalle_pedido dp
INNER JOIN ropa r ON dp.codigo_prenda = r.codigo_prenda
INNER JOIN tipo_ropa tr ON r.id_tipo_ropa = tr.id_tipo_ropa
GROUP BY tr.nombre_tipo
ORDER BY subtotal DESC
LIMIT 5;
"""

df_top5 = pd.read_sql_query(query_torta, con)
con.close()

# 3. Construcción del gráfico circular
plt.figure(figsize=(8, 6))
plt.pie(
    df_top5['subtotal'],
    labels=df_top5['producto'],
    autopct='%1.1f%%',
    startangle=140,
    wedgeprops={'edgecolor': 'white', 'linewidth': 1.5}
)
plt.title('Participación del Top 5 Tipos de Ropa Más Vendidos', fontweight='bold')
plt.axis('equal')
plt.tight_layout()
plt.show()