USE StackOverflow2010;
GO

--Ejercicio 1: Nombre y locacion de personas con la mejor reputacion ordenada de forma descendente
/*SELECT TOP 200 DisplayName, Location, Reputation FROM Users
ORDER BY Reputation DESC;*/

--Ejercicio 2: Nombre de los usuarios junto con sus respectivos posteos extraidos de la tabla Posts y Users
/*SELECT TOP 200 P.Title, U.DisplayName From Posts P
JOIN Users U ON P.OwnerUserId = U.Id;*/

--Ejercicio 3: Nombre de los usuarios con sus promedios 
/*SELECT TOP 200 U.DisplayName, AVG(P.Score) AS Promedio_Score FROM Posts P
JOIN Users U ON P.OwnerUserId = U.Id
GROUP BY U.DisplayName;*/

--Ejercicio 4: Nombre de los usuarios con mas de 100 comentarios 
/*SELECT TOP 200  U.DisplayName /*, COUNT(C.UserId) AS Total*/ FROM Comments C
JOIN Users U ON C.UserId = U.Id
GROUP BY U.DisplayName
HAVING COUNT(C.UserId) > 100;*/

--Ejercicio 5: Actualización de la columna Location de la tabla Users
/*BEGIN TRANSACTION;--Esta linea forma parte del metodo para mostrar el mensaje de actualización
UPDATE Users
SET Location = 'Desconocido'
WHERE LTRIM(RTRIM(Location)) = '';
	/*La estructura de esta condicional es la utilizada para mostrar mensajes en SQL Server
	(el método exacto puede variar dependiendo del sistema de gestión de bases de datos)*/
IF @@ROWCOUNT > 0
    PRINT 'Actualización Exitosa.';
ELSE
    PRINT 'No se realizaron actualizaciones.';

COMMIT;*/

--Para hacer pruebas de funcionamiento
--SELECT TOP 200 Location FROM Users;
/*BEGIN TRANSACTION;--Esta linea forma parte del metodo para mostrar el mensaje de actualizacion
UPDATE Users
SET Location = ''
WHERE Location = 'Desconocido';
	/*La estructura de esta condicional es la utilizada para mostrar mensajes en SQL Server
	(el método exacto puede variar dependiendo del sistema de gestión de bases de datos)*/
IF @@ROWCOUNT > 0
    PRINT 'Actualización Exitosa.';
ELSE
    PRINT 'No se realizaron actualizaciones.';

COMMIT;*/

--Ejercicio 6: Eliminar los comentarios de los usuarios con menos de 100 de reputación
/*BEGIN TRANSACTION;
-- Eliminar comentarios
DELETE FROM Comments
WHERE UserId IN (
	SELECT Id
	FROM Users 
	WHERE Reputation < 100
);
--Mostrar cantidad de filas eliminadas
IF @@ROWCOUNT > 0
    PRINT 'Eliminación Exitosa. ' + CAST(@@ROWCOUNT AS VARCHAR(50)) + ' comentarios fueron eliminados.';
ELSE
    PRINT 'No se realizaron eliminaciones.';

COMMIT;*/

--Para hacer la consulta de los resultados
/*SELECT TOP 200 C.UserId, C.Text, U.Reputation  FROM Comments C
JOIN Users U ON C.UserId = U.Id
WHERE Reputation < 100;*/

--Ejercicio 7: Total de publicaciones, comentarios y medallas por usuario.
/*SELECT TOP 10
    u.DisplayName,
    COUNT(p.Id) AS TotalPosts,
    COUNT(c.Id) AS TotalComments,
    COUNT(b.Id) AS TotalBadges
FROM 
    Users u
JOIN 
    Posts p ON u.Id = p.OwnerUserId
JOIN 
    Comments c ON u.Id = c.UserId
JOIN 
    Badges b ON u.Id = b.UserId
GROUP BY 
    u.DisplayName;*/

--Consultas por separado
/*SELECT TOP 200 C.Id, U.AccountId FROM Users U
JOIN Comments C ON U.AccountId = C.Id;*/

/*SELECT TOP 10 U.DisplayName, COUNT(P.Id) As TotalPosts FROM Users U
JOIN Posts p ON U.Id = P.OwnerUserId
GROUP By U.DisplayName;*/

/*SELECT TOP 10 U.DisplayName, COUNT(C.Id) As TotalComments FROM Users U
JOIN Comments C ON U.Id = C.UserId
GROUP By U.DisplayName;*/

/*SELECT TOP 10 U.DisplayName, COUNT(B.Id) As TotalBadges FROM Users U
JOIN Badges B ON U.Id = B.UserId
GROUP By U.DisplayName;*/

--Ejercicio 8: Las 10 pliblicaciones más populares sengun su puntuación
/*SELECT TOP 10 Title, Score FROM Posts
ORDER BY Score DESC;*/

--Ejercicio 9: Los 5 comentarios más recientes 
/*SELECT TOP 5 Text, CreationDate AS Fecha_de_Creacion FROM Comments
ORDER BY CreationDate DESC;*/