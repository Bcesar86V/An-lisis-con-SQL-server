--Consulta con la cantidad de registros de cada tabla--
Select Cantidad_de_registros=Count(*) 
From Comuna

Select Cantidad_de_registros=Count(*) 
From Dirección

Select Cantidad_de_registros=Count(*) 
From Pedido

Select Cantidad_de_registros=Count(*) 
From Pedido_item

Select Cantidad_de_registros=Count(*) 
From Producto

Select Cantidad_de_registros=Count(*) 
From Provincia

Select Cantidad_de_registros=Count(*) 
From Región



--3 primeros registros de pedido_item--
Select TOP 3 *
From Pedido_item

--Total de productos vendidos por categoria--
Select Producto.Categoría, productos_vendidos=sum(Pedido_item.Unidades)
From Producto inner join Pedido_item
on Producto.Producto_id=Pedido_item.Producto_id
Group by Categoría, unidades

--Total de productos vendidos por comuna--
Select Comuna.Comuna, Productos_Vendidos_Por_Comuna=sum(Pedido_item.unidades)
From Comuna inner join Dirección 
on Comuna.Comuna_id=Dirección.Comuna_id
inner join Pedido 
on Pedido.dirección_id=Dirección.Dirección_id
inner join Pedido_item
on Pedido.pedido_id=Pedido_item.pedido_id
Group by Comuna, Unidades

--Crear un reporte de ventas por año--
Select pedido.año, total_ventas=sum(pedido_item.unidades)
From Pedido left join Pedido_item
on pedido.pedido_id=pedido_item.pedido_id
group by año
order by año

--Total de unidades vendidas por Región--
Select Región.Región, Ventas_Por_Region=sum(pedido_item.unidades)
From Provincia inner join Región
on Provincia.Región_id=Región.Región_id
inner join Comuna
on Provincia.Provincia_id=Comuna.Provincia_id
inner join Dirección
on Dirección.Comuna_id=Comuna.Comuna_id
inner join Pedido
on Dirección.Dirección_id=Pedido.dirección_id
inner join pedido_item
on Pedido_item.pedido_id=pedido.pedido_id
Group by Región

--Categoría de productos vendidos--
Select Producto.Categoría, Total_ventas=sum(Pedido_item.precio*Pedido_item.unidades), Evaluación= case when sum(pedido_item.precio*pedido_item.unidades)<15000 then 'Tipo A'
when sum(pedido_item.precio*pedido_item.unidades)=15000 then 'Tipo B'
when sum(pedido_item.precio*pedido_item.unidades)>15000 then 'Tipo C'
end 
From Producto inner join Pedido_item
on Producto.Producto_id=Pedido_item.Producto_id
Group by Categoría

--Creación de procedimiento almacenado--
Create procedure Tablas_reporte_ventas
as
Select Comuna.Comuna, Productos_Vendidos_Por_Comuna=sum(Pedido_item.unidades)
From Comuna inner join Dirección 
on Comuna.Comuna_id=Dirección.Comuna_id
inner join Pedido 
on Pedido.dirección_id=Dirección.Dirección_id
inner join Pedido_item
on Pedido.pedido_id=Pedido_item.pedido_id
Group by Comuna, Unidades

Select Producto.Categoría, productos_vendidos=sum(Pedido_item.Unidades)
From Producto inner join Pedido_item
on Producto.Producto_id=Pedido_item.Producto_id
Group by Categoría, unidades

execute Tablas_reporte_ventas
