<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update/Delete Product</title>
</head>
<body>
    <h1>Update/Delete Product</h1>
    
    <!-- Form for updating a product -->
    <form method="post" action="updateProductAction.jsp">
        <label>Product Name:</label>
        <input type="text" name="productName" required><br>
        <label>New Price:</label>
        <input type="number" step="0.01" name="price"><br>
        <input type="submit" name="action" value="Update Product">
    </form>
    
    <br><br>
    
    <!-- Form for deleting a product -->
    <form method="post" action="updateProductAction.jsp">
        <label>Product Name to Delete:</label>
        <input type="text" name="deleteProductName" required><br>
        <input type="submit" name="action" value="Delete Product">
    </form>

    <br><br>

    <!-- Button to go back to admin page -->
    <button onclick="location.href='admin.jsp'">Back to Admin</button>
</body>
</html>