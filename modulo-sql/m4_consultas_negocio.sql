-- RetailPro | Pre-entrega 4: Consultas SQL de negocio
-- Base de datos: Ventas_Tech_DB (SQL Server)
-- Tabla utilizada: dbo.ventas

USE [Ventas_Tech_DB];
GO

-- Consulta 1: Resumen ejecutivo mensual
-- El ticket promedio se calcula sobre cada fila/pedido de ventas.
SELECT
    MONTH(fecha_venta) AS mes,
    CAST(SUM(cantidad * precio_unitario) AS DECIMAL(18, 2)) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    CAST(AVG(cantidad * precio_unitario) AS DECIMAL(18, 2)) AS ticket_promedio
FROM dbo.ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
GO

-- Consulta 2: Top 5 de productos por total facturado
SELECT TOP (5)
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    CAST(SUM(cantidad * precio_unitario) AS DECIMAL(18, 2)) AS total_facturado
FROM dbo.ventas
GROUP BY id_producto
ORDER BY SUM(cantidad * precio_unitario) DESC, id_producto ASC;
GO

-- Consulta 3: Clientes recurrentes (más de un pedido)
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    CAST(SUM(cantidad * precio_unitario) AS DECIMAL(18, 2)) AS total_gastado
FROM dbo.ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC, id_cliente ASC;
GO

-- Consulta 4: Facturación por producto comparada con el promedio
-- El promedio se calcula entre los totales agregados por producto.
WITH FacturacionPorProducto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM dbo.ventas
    GROUP BY id_producto
)
SELECT
    id_producto,
    CAST(total_facturado AS DECIMAL(18, 2)) AS total_facturado,
    CASE
        WHEN total_facturado > (
            SELECT AVG(CAST(total_facturado AS DECIMAL(18, 2)))
            FROM FacturacionPorProducto
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_con_promedio
FROM FacturacionPorProducto
ORDER BY total_facturado DESC, id_producto ASC;
GO

-- Hallazgos al revisar los resultados:
-- 1. En marzo de 2024 se facturaron $6,444.00 en 10 pedidos, con un ticket promedio de $644.40.
-- 2. El producto 1 lideró la facturación con $3,600.00, aproximadamente el 55.9% del total.
-- 3. Los cinco clientes realizaron 2 pedidos cada uno; el cliente 1 fue quien más gastó, con $2,640.00.
