<%@ page language="java" %>
<%
    session.invalidate(); // Kill the session
    response.sendRedirect("index.jsp"); // Redirect to index.jsp
%>