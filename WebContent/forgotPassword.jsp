<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>
    <div style="margin:0 auto;text-align:center;display:inline">
        <h1>Forgot Password</h1>
        <form method="post" action="validateForgotPassword.jsp">
            <label>Email:</label>
            <input type="email" name="email" required><br>
            <input type="submit" value="Reset Password">
        </form>
        <br><br>
        <button onclick="location.href='user.jsp'">Back to User Management</button>
    </div>
</body>
</html>