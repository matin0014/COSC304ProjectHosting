<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String action = request.getParameter("action");
    int customerId = Integer.parseInt(request.getParameter("customerId"));
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
        if ("Update Customer".equals(action)) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ? WHERE customerId = ?");
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, postalCode);
            pstmt.setString(9, country);
            pstmt.setInt(10, customerId);
            pstmt.executeUpdate();
        }
        response.sendRedirect("addCustomer.jsp");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>