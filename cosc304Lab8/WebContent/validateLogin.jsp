<%@ page language="java" import="java.io.*,java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    boolean authenticated = false;

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        PreparedStatement pstmt = con.prepareStatement("SELECT * FROM customer WHERE userid = ? AND password = ?");
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            authenticated = true;
            session.setAttribute("authenticatedUser", username);
            session.setAttribute("userId", rs.getInt("customerId"));
        }
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }

    if (authenticated) {
        response.sendRedirect("profile.jsp");
    } else {
        session.setAttribute("loginMessage", "Invalid username or password.");
        response.sendRedirect("user.jsp");
    }
%>
