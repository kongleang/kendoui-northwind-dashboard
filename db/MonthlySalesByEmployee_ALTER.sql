USE [C:\REPOS\KENDO-DASHBOARD\ASPNET-MVC\KENDOUI-NORTHWIND-DASHBOARD\APP_DATA\NORTHWIND.MDF]
GO
/****** Object:  StoredProcedure [dbo].[MonthlySalesByEmployee]    Script Date: 4/22/2014 14:53:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[MonthlySalesByEmployee]
	@EmployeeID INT
AS
BEGIN 
	SET NOCOUNT ON;

		SELECT  Orders.EmployeeID, 
				SUM((Quantity * UnitPrice) - (Quantity * UnitPrice * Discount))  AS EmployeeSales,  
				DATEFROMPARTS(DATEPART(YEAR, Orders.OrderDate), DATEPART(MONTH, Orders.OrderDate), 1) AS Date
		FROM [Order Details]
			INNER JOIN Orders ON Orders.OrderID = [Order Details].OrderID
		WHERE Orders.EmployeeID = @EmployeeID
		GROUP BY Orders.EmployeeID, DATEFROMPARTS(DATEPART(YEAR, Orders.OrderDate), DATEPART(MONTH, Orders.OrderDate), 1) 
END
