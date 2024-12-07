<%@ page import="java.text.NumberFormat, java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .button {
            padding: 10px 20px;
            margin: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container">
        <h1>Administrator Page</h1>

        <h2>Daily Sales Report</h2>
        <canvas id="salesChart" width="400" height="200"></canvas>
        <%
            StringBuilder salesData = new StringBuilder();
            StringBuilder salesLabels = new StringBuilder();
            try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();

                PreparedStatement statement = con.prepareStatement("SELECT year(orderDate) AS year, month(orderDate) AS month, day(orderDate) AS day, SUM(totalAmount) AS dayAmount FROM ordersummary GROUP BY year(orderDate), month(orderDate), day(orderDate);");
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.isBeforeFirst()) {
                    while (resultSet.next()) {
                        String date = resultSet.getString("year") + "-" + resultSet.getInt("month") + "-" + resultSet.getInt("day");
                        double amount = resultSet.getDouble("dayAmount");
                        salesLabels.append("'").append(date).append("',");
                        salesData.append(amount).append(",");
                    }
                } else {
                    out.print("<p>No sales data available.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>
        <script>
            var ctx = document.getElementById('salesChart').getContext('2d');
            var salesChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [<%= salesLabels.toString() %>],
                    datasets: [{
                        label: 'Daily Sales',
                        data: [<%= salesData.toString() %>],
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>

        <h2>All Customers</h2>
        <%
            try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
                PreparedStatement statement = con.prepareStatement("SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country FROM customer;");
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.isBeforeFirst()) {
                    out.print("<table><tr><th>Customer ID</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone</th><th>Address</th><th>City</th><th>State</th><th>Postal Code</th><th>Country</th></tr>");
                    while (resultSet.next()) {
                        out.print("<tr><td>" + resultSet.getInt("customerId") + "</td>");
                        out.print("<td>" + resultSet.getString("firstName") + "</td>");
                        out.print("<td>" + resultSet.getString("lastName") + "</td>");
                        out.print("<td>" + resultSet.getString("email") + "</td>");
                        out.print("<td>" + resultSet.getString("phonenum") + "</td>");
                        out.print("<td>" + resultSet.getString("address") + "</td>");
                        out.print("<td>" + resultSet.getString("city") + "</td>");
                        out.print("<td>" + resultSet.getString("state") + "</td>");
                        out.print("<td>" + resultSet.getString("postalCode") + "</td>");
                        out.print("<td>" + resultSet.getString("country") + "</td></tr>");
                    }
                    out.print("</table>");
                } else {
                    out.print("<p>No customer data available.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>

        <h2>Manage Products</h2>
        <button class="button" onclick="location.href='addProduct.jsp'">Add New Product</button>
        <button class="button" onclick="location.href='updateProduct.jsp'">Update/Delete Product</button>

        <h2>Manage Warehouse</h2>
        <button class="button" onclick="location.href='addWarehouse.jsp'">Add/Update Warehouse</button>

        <h2>Manage Customers</h2>
        <button class="button" onclick="location.href='addCustomer.jsp'">Add/Update Customer</button>

        <!-- Logout button -->
        <form method="post" action="logoutAdmin.jsp">
            <input class="button" type="submit" value="Log Out">
        </form>
    </div>
</body>
</html>
