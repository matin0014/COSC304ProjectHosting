<%@ page import="java.sql.*, java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Germain So, Matin Raoufi Grocery Order List</title>
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
    <a href="listprod.jsp">Shop Products</a>
</div>

<div class="container">
    <h1>Order List</h1>

    <%
        // Note: Forces loading of SQL Server driver
        try {    
            // Load driver class
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (java.lang.ClassNotFoundException e) {
            out.println("ClassNotFoundException: " + e);
        }

        // Make connection
        try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
            Statement stmt = con.createStatement();
            ResultSet rst = stmt.executeQuery("SELECT\n" +
                    "    o.orderId,\n" +
                    "    o.orderDate,\n" +
                    "    o.totalAmount,\n" +
                    "    c.customerId,\n" +
                    "    c.firstName,\n" +
                    "    c.lastName\n" +
                    "FROM\n" +
                    "    ordersummary o\n" +
                    "        JOIN customer c ON c.customerId = o.customerId\n");
            out.print("<table border = '1'><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");

            while (rst.next()) {
                int orderId = rst.getInt("orderId");
                String date = rst.getString("orderDate");
                int customerId = rst.getInt("customerId");
                String customerName = rst.getString("firstName") + " " + rst.getString("lastName");

                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();
                String totalAmount = currencyFormatter.format(rst.getDouble("totalAmount"));

                out.print("<tr>");
                out.print("<td>" + orderId + "</td><td>" + date + "</td><td>" + customerId + "</td><td>" + customerName
                        + "</td><td>" + totalAmount + "</td>");
                out.print("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\"><tbody><tr><th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");

                // list products in current order
                Statement stmt1 = con.createStatement();
                ResultSet rst1 = stmt1.executeQuery("select *\n" +
                        "from orderproduct\n" +
                        "where orderId = " + orderId + ";");

                while (rst1.next()) { // for each product in order
                    int product = rst1.getInt("productId");
                    int quantity = rst1.getInt("quantity");
                    String price = currencyFormatter.format(rst1.getDouble("price"));
                    out.print("<tr><td>" + product + "</td><td>" + quantity + "</td><td>" + price + "</td></tr>");
                }

                out.print("</tbody></table></tr>");
            }

            out.print("</table>");
        } catch (Exception e) {
            out.print(e);
        }
    %>

</div>

</body>
</html>
