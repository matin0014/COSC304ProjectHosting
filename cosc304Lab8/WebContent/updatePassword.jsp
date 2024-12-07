<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String email = request.getParameter("email");
    String newPassword = request.getParameter("newPassword");

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET password = ? WHERE email = ?");
        pstmt.setString(1, newPassword);
        pstmt.setString(2, email);
        pstmt.executeUpdate();
        session.setAttribute("passwordUpdateMessage", "Password updated successfully.");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }

    response.sendRedirect("user.jsp");
%>