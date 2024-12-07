<%@ page import="java.sql.*, java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
</head>
<body>
    <div style="margin:0 auto;text-align:center;display:inline">
        <h1>Profile</h1>

        <%
            int userId = (int) session.getAttribute("userId");
            String firstName = "";
            String lastName = "";

            try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
                PreparedStatement pstmt = con.prepareStatement("SELECT firstName, lastName FROM customer WHERE customerId = ?");
                pstmt.setInt(1, userId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    firstName = rs.getString("firstName");
                    lastName = rs.getString("lastName");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>

        <h2>Welcome, <%= firstName %> <%= lastName %></h2>

        <h2>Edit Profile</h2>
        <form method="post" action="updateProfile.jsp">
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
            <label>Username:</label>
            <input type="text" name="username"><br>
            <label>Password:</label>
            <input type="password" name="password"><br>
            <input type="submit" value="Update Profile">
        </form>

        <h2>Your Orders</h2>
        <%
            try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
                PreparedStatement pstmt = con.prepareStatement("SELECT orderId, orderDate, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry FROM ordersummary WHERE customerId = ?");
                pstmt.setInt(1, userId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.isBeforeFirst()) {
                    out.print("<table border='1'><tr><th>Order Id</th><th>Order Date</th><th>Total Amount</th><th>Shipping Address</th></tr>");
                    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();

                    while (rs.next()) {
                        int orderId = rs.getInt("orderId");
                        String orderDate = rs.getString("orderDate");
                        String totalAmount = currencyFormatter.format(rs.getDouble("totalAmount"));
                        String shippingAddress = rs.getString("shiptoAddress") + ", " + rs.getString("shiptoCity") + ", " + rs.getString("shiptoState") + ", " + rs.getString("shiptoPostalCode") + ", " + rs.getString("shiptoCountry");

                        out.print("<tr>");
                        out.print("<td>" + orderId + "</td><td>" + orderDate + "</td><td>" + totalAmount + "</td><td>" + shippingAddress + "</td>");
                        out.print("</tr>");
                    }
                    out.print("</table>");
                } else {
                    out.print("<p>No orders found.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>

        <h2>Your Payment Methods</h2>
        <%
            try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
                PreparedStatement pstmt = con.prepareStatement("SELECT paymentType, paymentNumber, paymentExpiryDate FROM paymentmethod WHERE customerId = ?");
                pstmt.setInt(1, userId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.isBeforeFirst()) {
                    out.print("<table border='1'><tr><th>Payment Type</th><th>Payment Number</th><th>Expiry Date</th></tr>");

                    while (rs.next()) {
                        String paymentType = rs.getString("paymentType");
                        String paymentNumber = rs.getString("paymentNumber");
                        String paymentExpiryDate = rs.getString("paymentExpiryDate");

                        out.print("<tr>");
                        out.print("<td>" + paymentType + "</td><td>" + paymentNumber + "</td><td>" + paymentExpiryDate + "</td>");
                        out.print("</tr>");
                    }
                    out.print("</table>");
                } else {
                    out.print("<p>No payment methods found.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>

        <h2>Delete Account</h2>
        <form method="post" action="deleteAccount.jsp">
            <input type="hidden" name="userId" value="<%= userId %>">
            <input type="submit" value="Delete Account">
        </form>

        <br><br>
        <button onclick="location.href='index.jsp'">Back to Main Page</button>
    </div>
</body>
</html>