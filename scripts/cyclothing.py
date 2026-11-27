import psycopg2
import sys
import pandas as pd
import matplotlib.pyplot as plt
con = None
con = psycopg2.connect(host='10.7.50.11',
                       database= 'cyclothing',
                       user= 'cyclothing_dev',
                       password= 'nMqst7a4')

# 2. Consulta adaptada a tus tablas Pedido y Detalle_Pedido
query_barras = """
SELECT
    TO_CHAR(p.fecha_pedido, 'YYYY-MM') AS mes,
    SUM(dp.precio_venta) AS total_ventas
FROM pedido p
JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY mes
ORDER BY mes;
"""

df_mes = pd.read_sql_query(query_barras, con)
con.close()

# 3. Construcción del gráfico
plt.figure(figsize=(9, 5))
barras = plt.bar(df_mes['mes'], df_mes['total_ventas'], color='#2b5c8f', width=0.5)
plt.title('Ventas Totales por Mes', fontweight='bold')
plt.xlabel('Mes')
plt.ylabel('Total ($)')
plt.grid(axis='y', linestyle='--', alpha=0.5)

# Etiquetas de valor encima de cada barra (proporcional al máximo para que no se desborde)
max_val = df_mes['total_ventas'].max()
for barra in barras:
    y = barra.get_height()
    plt.text(
        barra.get_x() + barra.get_width() / 2,
        y + (max_val * 0.02),
        f'${y:,.0f}',
        ha='center',
        fontsize=9
    )

plt.ylim(0, max_val * 1.15)
plt.tight_layout()
plt.show()