<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
    <style>
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
    <a href="listprod.jsp">Shop Products</a>
	<a href="listorder.jsp">Order List</a>
</div>

<%
    // Bonus for updating item quantity and removing item from cart
    String productIdToUpdate = request.getParameter("productId");
    String newQuantityStr = request.getParameter("newQuantity");

    @SuppressWarnings("unchecked")
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    if (productIdToUpdate != null && productList != null && productList.containsKey(productIdToUpdate)) {
        if (newQuantityStr != null && !newQuantityStr.isEmpty()) {
            try {
                int newQuantity = Integer.parseInt(newQuantityStr);
                if (newQuantity > 0) {
                    ArrayList<Object> product = productList.get(productIdToUpdate);
                    product.set(3, newQuantity); // Update the quantity in the product list
                    session.setAttribute("productList", productList); // Update the session attribute
                    out.println("<h2>Quantity for product with ID " + productIdToUpdate + " has been updated.</h2>");
                } else {
                    productList.remove(productIdToUpdate); // Remove item if quantity is set to 0 or less
                    session.setAttribute("productList", productList);
                    out.println("<h2>Product with ID " + productIdToUpdate + " has been removed from your cart.</h2>");
                }
            } catch (NumberFormatException e) {
                out.println("<h2>Invalid quantity entered for product ID " + productIdToUpdate + ".</h2>");
            }
        }
    }

    if (productList == null || productList.isEmpty()) {
        out.println("<h1>Your shopping cart is empty!</h1>");
    } else {
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();

        out.println("<h1>Your Shopping Cart</h1>");
        out.print("<table border='1'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
        out.println("<th>Price</th><th>Subtotal</th><th>Update Quantity</th><th>Remove</th></tr>");

        double total = 0;
        for (Map.Entry<String, ArrayList<Object>> entry : productList.entrySet()) {
            ArrayList<Object> product = entry.getValue();
            if (product.size() < 4) {
                out.println("<tr><td colspan='7'>Invalid product data. Expected four entries but got: " + product + "</td></tr>");
                continue;
            }

            String productId = (String) product.get(0);
            String productName = (String) product.get(1);
            double price = 0;
            int quantity = 0;

            try {
                price = Double.parseDouble(product.get(2).toString());
                quantity = Integer.parseInt(product.get(3).toString());
            } catch (Exception e) {
                out.println("<tr><td colspan='7'>Error processing product ID " + productId + "</td></tr>");
                continue;
            }

            double subtotal = price * quantity;
            total += subtotal;

            out.print("<tr>");
            out.print("<td>" + productId + "</td>");
            out.print("<td>" + productName + "</td>");
            out.print("<td align='center'>" + quantity + "</td>");
            out.print("<td align='right'>" + currFormat.format(price) + "</td>");
            out.print("<td align='right'>" + currFormat.format(subtotal) + "</td>");

            // Bonus for updating item quantity
            out.print("<td>");
            out.print("<form action='showcart.jsp' method='post'>");
            out.print("<input type='hidden' name='productId' value='" + productId + "'>");
            out.print("<input type='number' name='newQuantity' min='1' value='" + quantity + "'>");
            out.print("<input type='submit' value='Update'>");
            out.print("</form>");
            out.print("</td>");

            // Bonus for removing item from cart
            out.print("<td>");
            out.print("<form action='showcart.jsp' method='post'>");
            out.print("<input type='hidden' name='productId' value='" + productId + "'>");
            out.print("<input type='hidden' name='newQuantity' value='0'>"); 
            out.print("<input type='submit' value='Remove'>");
            out.print("</form>");
            out.print("</td>");

            out.print("</tr>");
        }

        out.println("<tr><td colspan='4' align='right'><b>Order Total</b></td>"
                + "<td align='right'>" + currFormat.format(total) + "</td><td colspan='2'></td></tr>");
        out.println("</table>");

        out.println("<h2><a href='checkout.jsp'>Check Out</a></h2>");
    }
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html>
