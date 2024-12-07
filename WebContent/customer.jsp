<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        PreparedStatement preparedStatement = con.prepareStatement("select *\n" +
                "from customer\n" +
                "where userid = ?;");
        preparedStatement.setString(1, userName);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()){
            out.print("<table border = '1'>");
            out.print("<tr><td><strong>Id</strong></td><td>" + resultSet.getString("customerId")+ "</td></tr>");
            out.print("<tr><td><strong>First name</strong></td><td>" + resultSet.getString("firstName")+ "</td></tr>");
            out.print("<tr><td><strong>Last name</strong></td><td>" + resultSet.getString("lastName")+ "</td></tr>");
            out.print("<tr><td><strong>Email</strong></td><td>" + resultSet.getString("email")+ "</td></tr>");
            out.print("<tr><td><strong>Phone</strong></td><td>" + resultSet.getString("phonenum")+ "</td></tr>");
            out.print("<tr><td><strong>Address</strong></td><td>" + resultSet.getString("address")+ "</td></tr>");
            out.print("<tr><td><strong>City</strong></td><td>" + resultSet.getString("city")+ "</td></tr>");
            out.print("<tr><td><strong>State</strong></td><td>" + resultSet.getString("state")+ "</td></tr>");
            out.print("<tr><td><strong>Postal Code</strong></td><td>" + resultSet.getString("postalCode")+ "</td></tr>");
            out.print("<tr><td><strong>Country</strong></td><td>" + resultSet.getString("country")+ "</td></tr>");
            out.print("<tr><td><strong>User id</strong></td><td>" + resultSet.getString("userid")+ "</td></tr>");
            out.print("</table>");
        }



    } catch (Exception e) {
        out.print(e);
    }

// Make sure to close connection
%>

</body>
</html>

