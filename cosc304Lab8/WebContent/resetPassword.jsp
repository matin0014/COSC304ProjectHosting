<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
    <div style="margin:0 auto;text-align:center;display:inline">
        <h1>Reset Password</h1>
        <form method="post" action="updatePassword.jsp">
            <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
            <label>New Password:</label>
            <input type="password" name="newPassword" required><br>
            <input type="submit" value="Update Password">
        </form>
        <br><br>
        <button onclick="location.href='user.jsp'">Back to User Management</button>
    </div>
</body>
</html>