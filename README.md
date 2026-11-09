# RetailPro Data Analytics

## Alcance del proyecto

Este repositorio reúne consultas SQL y un modelo de Power BI preparados para el caso RetailPro. La base `Ventas_Tech_DB` contiene datos de práctica de 10 ventas registradas entre el 5 y el 15 de marzo de 2024, con 5 clientes, 6 productos y 4 categorías. Los scripts permiten recrear la base, resumir la facturación, ordenar productos y enriquecer las ventas con información de clientes, productos y categorías.

La muestra sirve para documentar y practicar el flujo de análisis. Por su tamaño y período acotado, no permite afirmar tendencias comerciales generales ni estimar rentabilidad: el conjunto no incluye costos.

## Herramientas

- **SQL Server (T-SQL):** creación de la base y ejecución de consultas de negocio.
- **Power BI:** modelo del checkpoint 2, incluido como archivo `.pbix`.
- **Git y GitHub:** control de versiones y publicación de los entregables.

## Estructura

| Ruta | Contenido |
|---|---|
| `modulo-sql/ventas_tech_db.sql` | Crea `Ventas_Tech_DB`, las tablas y los datos de práctica. |
| `modulo-sql/m4_consultas_negocio.sql` | Resumen mensual, ranking de productos, clientes recurrentes y comparación con el promedio por producto. |
| `modulo-sql/m5_consultas_joins.sql` | Vista de ventas con `INNER JOIN`, búsquedas con `LEFT JOIN` y facturación por tramo de marzo. |
| `modulo-powerbi/Balsamo_Mateo_Checkpoint2.pbix` | Archivo del checkpoint 2 de Power BI. |

## Cómo ejecutar los scripts

1. Abrí una conexión a una instancia de SQL Server desde un cliente compatible con T-SQL.
2. Ejecutá `modulo-sql/ventas_tech_db.sql` para crear la base y cargar las tablas de práctica.
3. Ejecutá `modulo-sql/m4_consultas_negocio.sql` y `modulo-sql/m5_consultas_joins.sql` para obtener los resultados analíticos.
4. Abrí el archivo `.pbix` con Power BI Desktop para consultar el modelo del checkpoint.

**Atención:** `ventas_tech_db.sql` elimina y vuelve a crear las tablas `ventas`, `productos`, `clientes` y `categorias` antes de insertar los datos. Ejecutalo solo cuando puedas reemplazar el contenido de esas tablas.

## Consultas incluidas

- Facturación, cantidad de ventas y ticket promedio por mes.
- Cinco productos con mayor facturación, junto con sus unidades vendidas.
- Clientes con más de una compra y comparación de facturación por producto contra el promedio.
- Detalle de ventas con datos descriptivos y búsquedas de clientes o productos sin ventas.
- Facturación del 1 al 10 de marzo comparada con la del 11 al 31 de marzo.
