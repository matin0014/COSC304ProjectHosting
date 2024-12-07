<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String action = request.getParameter("action");
    String warehouseName = request.getParameter("warehouseName");
    String warehouseLocation = request.getParameter("warehouseLocation");

    try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
        if ("Add Warehouse".equals(action)) {
            PreparedStatement pstmt = con.prepareStatement("INSERT INTO warehouse (warehouseName, warehouseLocation) VALUES (?, ?)");
            pstmt.setString(1, warehouseName);
            pstmt.setString(2, warehouseLocation);
            pstmt.executeUpdate();
        } else if ("Update Warehouse".equals(action)) {
            PreparedStatement pstmt = con.prepareStatement("UPDATE warehouse SET warehouseLocation = ? WHERE warehouseName = ?");
            pstmt.setString(1, warehouseLocation);
            pstmt.setString(2, warehouseName);
            pstmt.executeUpdate();
        }
%>
        <script>
            window.location.href = "addWarehouse.jsp";
        </script>
<%
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>