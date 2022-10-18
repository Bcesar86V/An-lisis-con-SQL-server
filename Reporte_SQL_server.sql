--Consulta con la cantidad de registros de cada tabla--
Select Cantidad_de_registros=Count(*) 
From Comuna

Select Cantidad_de_registros=Count(*) 
From Direcci�n

Select Cantidad_de_registros=Count(*) 
From Pedido

Select Cantidad_de_registros=Count(*) 
From Pedido_item

Select Cantidad_de_registros=Count(*) 
From Producto

Select Cantidad_de_registros=Count(*) 
From Provincia

Select Cantidad_de_registros=Count(*) 
From Regi�n



--3 primeros registros de pedido_item--
Select TOP 3 *
From Pedido_item

--Total de productos vendidos por categoria--
Select Producto.Categor�a, productos_vendidos=sum(Pedido_item.Unidades)
From Producto inner join Pedido_item
on Producto.Producto_id=Pedido_item.Producto_id
Group by Categor�a, unidades

--Total de productos vendidos por comuna--
Select Comuna.Comuna, Productos_Vendidos_Por_Comuna=sum(Pedido_item.unidades)
From Comuna inner join Direcci�n 
on Comuna.Comuna_id=Direcci�n.Comuna_id
inner join Pedido 
on Pedido.direcci�n_id=Direcci�n.Direcci�n_id
inner join Pedido_item
on Pedido.pedido_id=Pedido_item.pedido_id
Group by Comuna, Unidades

--Crear un reporte de ventas por a�o--
Select pedido.a�o, total_ventas=sum(pedido_item.unidades)
From Pedido left join Pedido_item
on pedido.pedido_id=pedido_item.pedido_id
group by a�o
order by a�o

--Total de unidades vendidas por Regi�n--
Select Regi�n.Regi�n, Ventas_Por_Region=sum(pedido_item.unidades)
From Provincia inner join Regi�n
on Provincia.Regi�n_id=Regi�n.Regi�n_id
inner join Comuna
on Provincia.Provincia_id=Comuna.Provincia_id
inner join Direcci�n
on Direcci�n.Comuna_id=Comuna.Comuna_id
inner join Pedido
on Direcci�n.Direcci�n_id=Pedido.direcci�n_id
inner join pedido_item
on Pedido_item.pedido_id=pedido.pedido_id
Group by Regi�n

--Categor�a de productos vendidos--
Select Producto.Categor�a, Total_ventas=sum(Pedido_item.precio*Pedido_item.unidades), Evaluaci�n= case when sum(pedido_item.precio*pedido_item.unidades)<15000 then 'Tipo A'
when sum(pedido_item.precio*pedido_item.unidades)=15000 then 'Tipo B'
when sum(pedido_item.precio*pedido_item.unidades)>15000 then 'Tipo C'
end 
From Producto inner join Pedido_item
on Producto.Producto_id=Pedido_item.Producto_id
Group by Categor�a

--Creaci�n de procedimiento almacenado--
Create procedure Tablas_reporte_ventas
as
Select Comuna.Comuna, Productos_Vendidos_Por_Comuna=sum(Pedido_item.unidades)
From Comuna inner join Direcci�n 
on Comuna.Comuna_id=Direcci�n.Comuna_id
inner join Pedido 
on Pedido.direcci�n_id=Direcci�n.Direcci�n_id
inner join Pedido_item
on Pedido.pedido_id=Pedido_item.pedido_id
Group by Comuna, Unidades

Select Producto.Categor�a, productos_vendidos=sum(Pedido_item.Unidades)
From Producto inner join Pedido_item
on Producto.Producto_id=Pedido_item.Producto_id
Group by Categor�a, unidades

execute Tablas_reporte_ventas
