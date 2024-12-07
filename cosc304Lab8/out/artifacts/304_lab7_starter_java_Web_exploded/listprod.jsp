<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00

	NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();
	try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
		if (name == null){
			name = "";
		}
		PreparedStatement pstmt = con.prepareStatement("SELECT productId, productName, productPrice FROM orders.dbo.product WHERE productName LIKE ?" +
				"");
		pstmt.setString(1, "%" + name + "%");
		ResultSet rs = pstmt.executeQuery();


		//there is matching results
		if (rs.isBeforeFirst()){
			out.print("<table><tbody>");
			out.print("<tr><th></th><th>Product Name</th><th>Price</th></tr>");
		}


		while (rs.next()) {
			int id = rs.getInt("productId");
			String productName = rs.getString("productName");
			double price = rs.getDouble("productPrice");
			String formattedPrice = currencyFormatter.format(price);

			out.print("<tr>");
			out.print("<td><a href=\"addcart.jsp?id=" + id + "&name=" + productName + "&price=" + price + "\">Add to Cart</a></td>");
			out.print("<td>" + productName + "</td>");
			out.print("<td>" + formattedPrice + "</td>");
			out.print("</tr>");
		}

		out.print("</tbody></table>");
	} catch (Exception e) {
		out.print(e);
	}

%>

</body>
</html>