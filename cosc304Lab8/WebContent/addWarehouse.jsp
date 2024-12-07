<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add/Update Warehouse</title>
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
</head>
<body>
    <div class="container">
        <h1>Add Warehouse</h1>
        <form method="post" action="addWarehouseAction.jsp">
            <label>Warehouse Name:</label>
            <input type="text" name="warehouseName" required><br>
            <label>Warehouse Location:</label>
            <input type="text" name="warehouseLocation" required><br>
            <input type="submit" name="action" value="Add Warehouse">
        </form>

        <h1>Update Warehouse</h1>
        <form method="post" action="addWarehouseAction.jsp">
            <label>Warehouse Name:</label>
            <input type="text" name="warehouseName" required><br>
            <label>New Warehouse Location:</label>
            <input type="text" name="warehouseLocation" required><br>
            <input type="submit" name="action" value="Update Warehouse">
        </form>

        <h2>All Warehouses</h2>
        <%
            try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
                PreparedStatement statement = con.prepareStatement("SELECT warehouseName, warehouseLocation FROM warehouse;");
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.isBeforeFirst()) {
                    out.print("<table><tr><th>Warehouse Name</th><th>Warehouse Location</th></tr>");
                    while (resultSet.next()) {
                        out.print("<tr><td>" + resultSet.getString("warehouseName") + "</td>");
                        out.print("<td>" + resultSet.getString("warehouseLocation") + "</td></tr>");
                    }
                    out.print("</table>");
                } else {
                    out.print("<p>No warehouse data available.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>

        <button class="button" onclick="location.href='admin.jsp'">Back to Admin</button>
    </div>
</body>
</html>