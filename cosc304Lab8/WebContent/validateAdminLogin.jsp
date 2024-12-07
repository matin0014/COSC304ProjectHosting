<%@ page language="java" import="java.io.*,java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String authenticatedAdmin = null;
    session = request.getSession(true);

    try {
        authenticatedAdmin = validateAdminLogin(out, request, session);
    } catch (IOException e) {
        System.err.println(e);
    }

    if (authenticatedAdmin != null)
        response.sendRedirect("admin.jsp");        // Successful login
    else
        response.sendRedirect("adminlogin.jsp");   // Failed login - redirect back to admin login page with a message
%>

<%!
    String validateAdminLogin(JspWriter out, HttpServletRequest request, HttpSession session) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String retStr = null;

        if (username == null || password == null)
            return null;
        if ((username.length() == 0) || (password.length() == 0))
            return null;

        try {
            getConnection();

            PreparedStatement pstmt = con.prepareStatement("SELECT username, password FROM Admin WHERE username = ? and password = ?");
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                retStr = rst.getString("username");
            }

        } catch (SQLException ex) {
            out.println(ex);
        } finally {
            closeConnection();
        }

        if (retStr != null) {
            session.removeAttribute("adminLoginMessage");
            session.setAttribute("authenticatedAdmin", username);
        } else {
            session.setAttribute("adminLoginMessage", "Invalid admin username/password.");
        }

        return retStr;
    }
%>