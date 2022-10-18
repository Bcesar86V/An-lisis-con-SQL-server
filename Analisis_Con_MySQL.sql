#Alimento de cada animal segun su nombre particular
SELECT ANIMAL.Name, ANIMAL.Species, FEEDING.FoodType 
FROM ANIMAL INNER JOIN FEEDING 
on ANIMAL.Species = FEEDING.Species
;

#Animales para cada clase e inversion por alimento
SELECT COUNT(ANIMAL.Name) as Cantidad_Animales, ANIMAL.Class, sum(FEEDING.FoodPrice) as Inversion_Alimento 
FROM ANIMAL INNER JOIN FEEDING 
on ANIMAL.Species = FEEDING.Species
GROUP BY ANIMAL.Class;

#Personas que alimentan a los animales
SELECT EMPLOYEE.EmployeeFullName, ZSKILLS.Skill
FROM EMPLOYEE INNER JOIN ZOOKEEPER 
on EMPLOYEE.EmployeeID = ZOOKEEPER.ZEmpID
INNER JOIN ZSKILLS 
on ZOOKEEPER.KeeperID = ZSKILLS.KSkillID
;

#Alimentos registrados
SELECT COUNT(FEEDING.FoodType) as Tipo_Alimento_Reg
FROM FEEDING;

#Bonos para trabajadores que ingresaron antes del 2000
SELECT EMPLOYEE.HireDate, EMPLOYEE.EmployeeFullName, EMPLOYEE.EmployeeID 
FROM EMPLOYEE 
WHERE EMPLOYEE.HireDate BETWEEN '1950-01-01' AND '1999-12-31';

#Trabajador de cuidados intensivos
SELECT EMPLOYEE.EmployeeFullName, EMPLOYEE.EmployeeID 
FROM EMPLOYEE INNER JOIN ZOOKEEPER 
on EMPLOYEE.EmployeeID =ZOOKEEPER.ZEmpID 
INNER JOIN ZSKILLS 
on ZOOKEEPER.KeeperID = ZSKILLS.KSkillID 
WHERE ZSKILLS.Skill LIKE 'Intensive Care';


#NOMBRE, SALARIO, ACTIV ESPECIFICA
SELECT EMPLOYEE.EmployeeFullName, ZOOKEEPER.Salary, ZSKILLS.Skill 
FROM EMPLOYEE INNER JOIN ZOOKEEPER 
on EMPLOYEE.EmployeeID =ZOOKEEPER.ZEmpID 
INNER JOIN ZSKILLS 
on ZOOKEEPER.KeeperID =ZSKILLS.KSkillID;

#STAFF DEL ZOOLOGICO
SELECT PERSON.FullName , OSTAFF.Department 
FROM OSTAFF INNER JOIN EMPLOYEE 
on EMPLOYEE.EmployeeID =OSTAFF.OEmpID
INNER JOIN PERSON
on PERSON.FullName =EMPLOYEE.EmployeeFullName ;

#DINERO PAGADO POR CADA TIPO DE TRABAJADOR
SELECT SUM(Salary) AS Money_Paid, Department
FROM OSTAFF 
GROUP BY Department;

#Segmentos de personas que habria que atraer
SELECT VISITOR.VisitorCategory, COUNT(VISITOR.VisitorCategory) AS Total_Por_Categoria,
SUM(VISITOR.TicketPrice) AS _Total_Recaudado
FROM VISITOR INNER JOIN PERSON
on VISITOR.VisitorFullName =PERSON.FullName
GROUP BY VisitorCategory;

#Estado de las personas que mas van al zoologico
SELECT PERSON.US_State, COUNT(PERSON.US_State) AS Visitantes_Por_Estado, SUM(VISITOR.TicketPrice) AS Total_Recaudado
FROM PERSON INNER JOIN VISITOR 
on VISITOR.VisitorFullName = PERSON.FullName 
GROUP BY US_State
ORDER BY COUNT(PERSON.US_State) DESC;

#Ticket promedio del estado donde las personas visitan mas al zoologico
SELECT  PERSON.US_State, AVG(VISITOR.TicketPrice) AS Ticket_Promedio, COUNT(PERSON.US_State) AS Personas_Por_Estado
FROM PERSON INNER JOIN VISITOR 
on VISITOR.VisitorFullName =PERSON.FullName 
GROUP BY US_State
ORDER BY COUNT(PERSON.US_State) DESC;

#Estado donde se encuentran los adultos que mas visitan el zoologico
SELECT PERSON.US_State, COUNT(VISITOR.VisitorCategory) AS Adultos_Por_Estado
FROM VISITOR INNER JOIN PERSON 
on VISITOR.VisitorFullName =PERSON.FullName 
WHERE VisitorCategory LIKE 'ADULTO/A'
GROUP BY US_State
ORDER BY COUNT(VISITOR.VisitorCategory) DESC;

#Ciudad donde se encuentra la mayoria de los invitados
SELECT COUNT(VISITOR.TicketType) AS TicketDia_Por_Ciudad, PERSON.City  
FROM PERSON INNER JOIN VISITOR 
on VISITOR.VisitorFullName =PERSON.FullName 
WHERE VISITOR.TicketType LIKE 'Day'
GROUP BY City
ORDER BY COUNT(VISITOR.TicketType) DESC;





