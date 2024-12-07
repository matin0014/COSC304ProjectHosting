<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    int userId = Integer.parseInt(request.getParameter("userId"));

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        PreparedStatement pstmt = con.prepareStatement("DELETE FROM customer WHERE customerId = ?");
        pstmt.setInt(1, userId);
        pstmt.executeUpdate();
        session.invalidate(); // Kill the session
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }

    response.sendRedirect("index.jsp");
%>