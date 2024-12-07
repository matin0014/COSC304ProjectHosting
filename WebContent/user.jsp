<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
</head>
<body>
    <div style="margin:0 auto;text-align:center;display:inline">
        <h1>User Management</h1>

        <h2>Login</h2>
        <form method="post" action="validateLogin.jsp">
            <label>Username:</label>
            <input type="text" name="username" required><br>
            <label>Password:</label>
            <input type="password" name="password" required><br>
            <input type="submit" value="Login">
        </form>

        <h2>Register</h2>
        <form method="post" action="user.jsp">
            <label>First Name:</label>
            <input type="text" name="firstName" required><br>
            <label>Last Name:</label>
            <input type="text" name="lastName" required><br>
            <label>Email:</label>
            <input type="email" name="email" required><br>
            <label>Phone:</label>
            <input type="text" name="phone" required><br>
            <label>Address:</label>
            <input type="text" name="address" required><br>
            <label>City:</label>
            <input type="text" name="city" required><br>
            <label>State:</label>
            <input type="text" name="state" required><br>
            <label>Postal Code:</label>
            <input type="text" name="postalCode" required><br>
            <label>Country:</label>
            <input type="text" name="country" required><br>
            <label>Username:</label>
            <input type="text" name="username" required><br>
            <label>Password:</label>
            <input type="password" name="password" required><br>
            <input type="submit" name="action" value="Register">
        </form>

        <h2>Forgot Password</h2>
        <form method="post" action="forgotPassword.jsp">
            <label>Email:</label>
            <input type="email" name="email" required><br>
            <input type="submit" value="Reset Password">
        </form>

        <br><br>
        <button onclick="location.href='index.jsp'">Back to Main Page</button>

        <% 
            if ("POST".equalsIgnoreCase(request.getMethod()) && "Register".equals(request.getParameter("action"))) {
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
                    PreparedStatement pstmt = con.prepareStatement("INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                    pstmt.setString(1, firstName);
                    pstmt.setString(2, lastName);
                    pstmt.setString(3, email);
                    pstmt.setString(4, phone);
                    pstmt.setString(5, address);
                    pstmt.setString(6, city);
                    pstmt.setString(7, state);
                    pstmt.setString(8, postalCode);
                    pstmt.setString(9, country);
                    pstmt.setString(10, username);
                    pstmt.setString(11, password);
                    pstmt.executeUpdate();
                    session.setAttribute("registerMessage", "Registered!");
                    response.sendRedirect("user.jsp");
                } catch (SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }

            String registerMessage = (String) session.getAttribute("registerMessage");
            if (registerMessage != null) {
                out.println("<p>" + registerMessage + "</p>");
                session.removeAttribute("registerMessage");
            }
        %>
    </div>
</body>
</html>