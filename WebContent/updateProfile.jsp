<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    int userId = (int) session.getAttribute("userId");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        if (firstName != null && !firstName.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET firstName = ? WHERE customerId = ?");
            pstmt.setString(1, firstName);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (lastName != null && !lastName.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET lastName = ? WHERE customerId = ?");
            pstmt.setString(1, lastName);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (email != null && !email.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET email = ? WHERE customerId = ?");
            pstmt.setString(1, email);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (phone != null && !phone.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET phonenum = ? WHERE customerId = ?");
            pstmt.setString(1, phone);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (address != null && !address.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET address = ? WHERE customerId = ?");
            pstmt.setString(1, address);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (city != null && !city.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET city = ? WHERE customerId = ?");
            pstmt.setString(1, city);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (state != null && !state.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET state = ? WHERE customerId = ?");
            pstmt.setString(1, state);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (postalCode != null && !postalCode.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET postalCode = ? WHERE customerId = ?");
            pstmt.setString(1, postalCode);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (country != null && !country.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET country = ? WHERE customerId = ?");
            pstmt.setString(1, country);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (username != null && !username.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET userid = ? WHERE customerId = ?");
            pstmt.setString(1, username);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        if (password != null && !password.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE customer SET password = ? WHERE customerId = ?");
            pstmt.setString(1, password);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        }
        session.setAttribute("profileUpdateMessage", "Profile updated successfully.");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }

    response.sendRedirect("profile.jsp");
%>