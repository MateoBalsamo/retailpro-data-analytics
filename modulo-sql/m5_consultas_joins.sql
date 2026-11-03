-- RetailPro | Pre-entrega 5: Consultas con JOINs para el proyecto
-- Base de datos: Ventas_Tech_DB (SQL Server)

USE [Ventas_Tech_DB];
GO

-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Propósito: reunir ventas, clientes, productos y categorías para alimentar el análisis en Power BI.
SELECT
    v.fecha_venta,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS ciudad_cliente,
    p.nombre_producto,
    cat.nombre_categoria AS categoria_producto,
    v.cantidad,
    v.precio_unitario,
    CAST(v.cantidad * v.precio_unitario AS DECIMAL(18, 2)) AS total_venta
FROM dbo.ventas AS v
INNER JOIN dbo.clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN dbo.productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN dbo.categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;
GO
-- Hallazgo: las 10 ventas quedan enriquecidas con nombre de cliente, ciudad, producto y categoría; ciudad y categoría permiten agrupar y filtrar el análisis.
GO

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: encontrar clientes registrados que todavía no hicieron compras, para que CRM pueda darles seguimiento.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM dbo.clientes AS c
LEFT JOIN dbo.ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.fecha_registro, c.id_cliente;
GO
-- Hallazgo: no aparecieron clientes sin compras entre los 5 registrados; en esta muestra, CRM no tiene clientes pendientes de su primera compra.
GO

-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: encontrar artículos del catálogo sin movimiento para que el área de producto revise su desempeño y disponibilidad.
SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM dbo.productos AS p
LEFT JOIN dbo.ventas AS v
    ON p.id_producto = v.id_producto
LEFT JOIN dbo.categorias AS cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL
ORDER BY cat.nombre_categoria, p.nombre_producto;
GO
-- Hallazgo: no aparecieron productos sin ventas entre los 6 del catálogo; todos tuvieron movimiento en la muestra.
GO

-- Consulta 4: Consolidado por canal (UNION ALL)
-- Propósito: comparar la facturación de dos tramos de marzo. Los valores de canal se generan como literales para identificar cada origen.
SELECT
    canal,
    CAST(SUM(total) AS DECIMAL(18, 2)) AS total_canal
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        CAST('Marzo 1-10' AS VARCHAR(20)) AS canal
    FROM dbo.ventas
    WHERE fecha_venta >= '20240301'
      AND fecha_venta <  '20240311'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        CAST('Marzo 11-31' AS VARCHAR(20)) AS canal
    FROM dbo.ventas
    WHERE fecha_venta >= '20240311'
      AND fecha_venta <  '20240401'
) AS consolidado
GROUP BY canal
ORDER BY canal;
GO
-- Hallazgo: del 1 al 10 de marzo se facturaron $3,620.00 y del 11 al 31, $2,824.00; el primer tramo superó al segundo por $796.00.
GO

