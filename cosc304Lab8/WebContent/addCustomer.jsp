<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add/Update Customer</title>
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
        <h1>Add Customer</h1>
        <form method="post" action="addCustomerAction.jsp">
            <label>First Name:</label>
            <input type="text" name="firstName" required><br>
            <label>Last Name:</label>
            <input type="text" name="lastName" required><br>
            <label>Email:</label>
            <input type="email" name="email" required><br>
            <label>Phone:</label>
            <input type="text" name="phone" required><br>
            <label>Address:</label>
            <input type="text" name="address" required><br>
            <label>City:</label>
            <input type="text" name="city" required><br>
            <label>State:</label>
            <input type="text" name="state" required><br>
            <label>Postal Code:</label>
            <input type="text" name="postalCode" required><br>
            <label>Country:</label>
            <input type="text" name="country" required><br>
            <input type="submit" name="action" value="Add Customer">
        </form>

        <h1>Update Customer</h1>
        <form method="post" action="updateCustomerAction.jsp">
            <label>Customer ID:</label>
            <input type="number" name="customerId" required><br>
            <label>First Name:</label>
            <input type="text" name="firstName"><br>
            <label>Last Name:</label>
            <input type="text" name="lastName"><br>
            <label>Email:</label>
            <input type="email" name="email"><br>
            <label>Phone:</label>
            <input type="text" name="phone"><br>
            <label>Address:</label>
            <input type="text" name="address"><br>
            <label>City:</label>
            <input type="text" name="city"><br>
            <label>State:</label>
            <input type="text" name="state"><br>
            <label>Postal Code:</label>
            <input type="text" name="postalCode"><br>
            <label>Country:</label>
            <input type="text" name="country"><br>
            <input type="submit" name="action" value="Update Customer">
        </form>

        <button class="button" onclick="location.href='admin.jsp'">Back to Admin</button>
    </div>
</body>
</html>