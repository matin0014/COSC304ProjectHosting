<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String action = request.getParameter("action");

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        if ("Update Product".equals(action)) {
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));

            PreparedStatement pstmt = con.prepareStatement("UPDATE product SET productPrice = ? WHERE productName = ?");
            pstmt.setDouble(1, price);
            pstmt.setString(2, productName);
            pstmt.executeUpdate();
        } else if ("Delete Product".equals(action)) {
            String deleteProductName = request.getParameter("deleteProductName");

            PreparedStatement pstmt = con.prepareStatement("DELETE FROM product WHERE productName = ?");
            pstmt.setString(1, deleteProductName);
            pstmt.executeUpdate();
        }
        response.sendRedirect("admin.jsp");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>