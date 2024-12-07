<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="java.sql.Date" %>

<!DOCTYPE html>
<html>
<head>
    <title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<%
    // Get customer id
    String custId = request.getParameter("customerId");
    boolean valid = true;
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        PreparedStatement pstmt = con.prepareStatement("select *\n" +
                "from orders.dbo.customer\n" +
                "where customerId = ?;");

        pstmt.setString(1, custId);
        ResultSet rst = pstmt.executeQuery();

        if (!rst.isBeforeFirst() || !custId.chars().allMatch(Character::isDigit)) { //no matching result or custId is not all numbers
            out.print("invalid customer id <br>");
            valid = false;
        }
    } catch (Exception e) {
        out.print(e);
    }


// Determine if there are products in the shopping cart
    if (valid && (productList == null || productList.isEmpty())) {
        out.print("empty shopping cart");
        valid = false;
    }
// If either are not true, display an error message


// Make connection
    if (valid) {
        try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {

            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            LocalDateTime now = LocalDateTime.now();
            Timestamp timestamp = Timestamp.valueOf(now);

            // Save order information to database
            PreparedStatement pstmt = con.prepareStatement("INSERT INTO orders.dbo.ordersummary (orderDate, customerId) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS);
            pstmt.setTimestamp(1, timestamp);
            pstmt.setString(2, custId);
            pstmt.executeUpdate();
            ResultSet keys = pstmt.getGeneratedKeys();
            keys.next();
            int orderId = keys.getInt(1);

            double totalPrice = 0;
            for (Map.Entry<String, ArrayList<Object>> entry : productList.entrySet()) {
                ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
                String productId = (String) product.get(0);
                String price = (String) product.get(2);
                double pr = Double.parseDouble(price);
                int qty = (Integer) product.get(3);
                totalPrice += pr * qty;

                pstmt = con.prepareStatement("INSERT INTO orders.dbo.orderproduct (orderId, productId, quantity, price) VALUES (?,?,?,?)");
                pstmt.setInt(1, orderId);
                pstmt.setString(2, productId);
                pstmt.setInt(3, qty);
                pstmt.setDouble(4, pr);
                pstmt.executeUpdate();
            }


            //update order total
            pstmt = con.prepareStatement("UPDATE orders.dbo.ordersummary SET totalAmount = ? WHERE orderId = ?");
            pstmt.setDouble(1, totalPrice);
            pstmt.setInt(2, orderId);
            pstmt.executeUpdate();

            out.println("<h1>Your Order Summary</h1>");
            out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
            out.println("<th>Price</th><th>Subtotal</th></tr>");

            double total = 0;
            Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
                if (product.size() < 4) {
                    out.println("Expected product with four entries. Got: " + product);
                    continue;
                }

                out.print("<tr><td>" + product.get(0) + "</td>");
                out.print("<td>" + product.get(1) + "</td>");

                out.print("<td align=\"center\">" + product.get(3) + "</td>");
                Object price = product.get(2);
                Object itemqty = product.get(3);
                double pr = 0;
                int qty = 0;

                try {
                    pr = Double.parseDouble(price.toString());
                } catch (Exception e) {
                    out.println("Invalid price for product: " + product.get(0) + " price: " + price);
                }
                try {
                    qty = Integer.parseInt(itemqty.toString());
                } catch (Exception e) {
                    out.println("Invalid quantity for product: " + product.get(0) + " quantity: " + qty);
                }

                out.print("<td align=\"right\">" + currFormat.format(pr) + "</td>");
                out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td></tr>");
                out.println("</tr>");
                total = total + pr * qty;
            }
            out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                    + "<td align=\"right\">" + currFormat.format(total) + "</td></tr>");
            out.println("</table>");

            out.println("<h1>Order completed.  Will be shipped soon...</h1>");
            out.println("<h1>Your order reference number is: " + orderId + "</h1>");
            out.println("<h1>Shipping to customer: " + custId + "</h1>");


            //clear shopping cart
            productList.clear();


        } catch (Exception e) {
            out.print(e);
        }
    }



	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/


// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

