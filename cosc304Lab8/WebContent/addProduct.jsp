<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>
</head>
<body>
    <h1>Add New Product</h1>
    <form method="post" action="addProductAction.jsp">
        <label>Product Name:</label>
        <input type="text" name="productName" required><br>
        <label>Price:</label>
        <input type="number" step="0.01" name="price" required><br>
        <input type="submit" value="Add Product">
    </form>

    <br><br>

    <!-- Button to go back to admin page -->
    <button onclick="location.href='admin.jsp'">Back to Admin</button>
</body>
</html>