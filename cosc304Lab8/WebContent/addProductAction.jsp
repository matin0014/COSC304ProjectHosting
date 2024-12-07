<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String productName = request.getParameter("productName");
    double price = Double.parseDouble(request.getParameter("price"));

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        PreparedStatement pstmt = con.prepareStatement("INSERT INTO product (productName, productPrice) VALUES (?, ?)");
        pstmt.setString(1, productName);
        pstmt.setDouble(2, price);
        pstmt.executeUpdate();
        response.sendRedirect("admin.jsp");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>