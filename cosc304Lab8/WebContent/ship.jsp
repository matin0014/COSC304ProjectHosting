<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>

<%@ include file="header.jsp" %>

<%
    String orderId = request.getParameter("orderId");
    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {

        //Check if valid order id in database
        String sql = "SELECT orderId FROM ordersummary WHERE orderId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, orderId);
        ResultSet orderIdResultSet = pstmt.executeQuery();
        if (!orderIdResultSet.next()) {
            out.println("<h1>Invalid order id</h1>");
            return;
        }


        // Start a transaction (turn-off auto-commit)
        con.setAutoCommit(false);

        // Retrieve all items in order with given id
        sql = "SELECT * FROM orderproduct WHERE orderId = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, orderId);
        ResultSet itemResultSet = pstmt.executeQuery();

        int validItemCnt = 0;

        while (itemResultSet.next()) {
            if (validItemCnt >= 3) {
                con.rollback();
                out.println("<h1>too many items</h1>");
                return;
            }
            int productId = itemResultSet.getInt("productId");
            int quantity = itemResultSet.getInt("quantity");

            //For each item verify sufficient quantity available in warehouse 1.
            sql = "select productId,quantity\n" +
                    "from productinventory\n" +
                    "where productId = ? and warehouseId = 1;";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, productId);
            ResultSet invRst = pstmt.executeQuery();
            int availableQuantity = 0;

            //If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
            if (invRst.next()) {
                availableQuantity = invRst.getInt("quantity");
                if (availableQuantity < quantity) {
                    con.rollback();
                    out.println("<h1>Insufficient inventory for product id: " + productId + "</h1>");
                    return;
                }
            } else {
                con.rollback();
                out.println("<h1>No inventory found for product id: " + productId + "</h1>");
                return;
            }

            int previousInventory = availableQuantity;
            int newInventory = previousInventory - quantity;
            sql = "UPDATE productinventory SET quantity = ? WHERE productId = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, newInventory);
            pstmt.setInt(2, productId);
            pstmt.executeUpdate();

            out.println("<h1>Ordered product: " + productId +" Qty: " + quantity +
                    " Previous inventory: " + previousInventory + " new inventory: " + newInventory+ "</h1>");

            validItemCnt++;
        }

        con.commit();
        con.setAutoCommit(true);

        out.println("<h1>Shipment processed successfully</h1>");





    } catch (SQLException e) {
        out.print(e);
    }




    // TODO: Create a new shipment record.

%>

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
