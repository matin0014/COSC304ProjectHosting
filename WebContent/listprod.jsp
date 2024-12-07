<%@ page import="java.sql.*, java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Germain So, Matin Raoufi Grocery</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 0;
        }
        h1 {
            background-color: #000000;
            color: white;
            padding: 15px;
            text-align: center;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        form {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 8px;
            width: 70%;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"], input[type="reset"] {
            padding: 10px 15px;
            background-color: #ff0000;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        select {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 20%;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f1f1f1;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .product-link {
            color: #007bff;
            text-decoration: none;
        }
        .product-link:hover {
            text-decoration: underline;
        }
        .header {
            background-color: #000000;
            color: white;
            padding: 15px;
            text-align: center;
        }
        .header a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
        }
        .header a:hover {
            background-color: #333;
        }
    </style>
</head>
<body>

<!-- Header -->
<div class="header">
    <a href="shop.html">Home</a>
    <a href="showcart.jsp">Your Cart</a>
    <a href="listorder.jsp">Order List</a>
   
</div>

<div class="container">
    <h1>Search for Products</h1>

    <form method="get" action="Desktop/OneDrive - UBC/Study/COSC 304/cosc304Lab8/WebContent/listprod.jsp">
        <input type="text" name="productName" placeholder="Enter product name..." size="50">
        <select name="categoryId">
            <option value="">Select Category</option>
            <%
                // Fetch categories for the filter
                try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
                    PreparedStatement pstmt = con.prepareStatement("SELECT categoryId, categoryName FROM category");
                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int categoryId = rs.getInt("categoryId");
                        String categoryName = rs.getString("categoryName");
            %>
                        <option value="<%= categoryId %>"><%= categoryName %></option>
            <%
                    }
                } catch (Exception e) {
                    out.print("Error loading categories: " + e.getMessage());
                }
            %>
        </select>
        <input type="submit" value="Search">
        <input type="reset" value="Reset">
    </form>

    <%
        String name = request.getParameter("productName");
        String categoryId = request.getParameter("categoryId");

        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();

        try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
            if (name == null) {
                name = "";
            }

            StringBuilder queryBuilder = new StringBuilder("SELECT productId, productName, productPrice FROM product WHERE productName LIKE ?");

            // Add category filter to the query if a category is selected
            if (categoryId != null && !categoryId.isEmpty()) {
                queryBuilder.append(" AND categoryId = ?");
            }

            PreparedStatement pstmt = con.prepareStatement(queryBuilder.toString());
            pstmt.setString(1, "%" + name + "%");

            // If a category is selected, set the categoryId parameter
            if (categoryId != null && !categoryId.isEmpty()) {
                pstmt.setInt(2, Integer.parseInt(categoryId));
            }

            ResultSet rs = pstmt.executeQuery();

            if (rs.isBeforeFirst()) {
                out.print("<table>");
                out.print("<thead><tr><th>Product Name</th><th>Price</th><th>Action</th></tr></thead>");
                out.print("<tbody>");
                while (rs.next()) {
                    int id = rs.getInt("productId");
                    String productName = rs.getString("productName");
                    double price = rs.getDouble("productPrice");
                    String formattedPrice = currencyFormatter.format(price);

                    out.print("<tr>");
                    out.print("<td><a href=\"product.jsp?id=" + id +"\" </a>" + productName + "</td>");
                    out.print("<td>" + formattedPrice + "</td>");
                    out.print("<td><a href=\"addcart.jsp?id=" + id + "&name=" + productName + "&price=" + price + "\" class=\"product-link\">Add to Cart</a></td>");
                    out.print("</tr>");
                }
                out.print("</tbody>");
                out.print("</table>");
            } else {
                out.print("<p>No products found matching your criteria.</p>");
            }
        } catch (Exception e) {
            out.print("Error: " + e.getMessage());
        }
    %>
</div>

</body>
</html>
