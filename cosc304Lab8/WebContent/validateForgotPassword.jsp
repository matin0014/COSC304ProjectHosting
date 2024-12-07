<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String email = request.getParameter("email");
    boolean emailExists = false;

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        PreparedStatement pstmt = con.prepareStatement("SELECT email FROM customer WHERE email = ?");
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            emailExists = true;
        }
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }

    if (emailExists) {
        response.sendRedirect("resetPassword.jsp?email=" + email);
    } else {
        session.setAttribute("forgotPasswordMessage", "Email does not exist in our records.");
        response.sendRedirect("forgotPassword.jsp");
    }
%>