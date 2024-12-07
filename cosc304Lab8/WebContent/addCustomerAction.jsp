<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String action = request.getParameter("action");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        if ("Add Customer".equals(action)) {
            PreparedStatement pstmt = con.prepareStatement("INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, postalCode);
            pstmt.setString(9, country);
            pstmt.executeUpdate();
        }
        response.sendRedirect("addCustomer.jsp");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>