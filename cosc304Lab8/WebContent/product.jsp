<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Ray's Grocery - Product Information</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
    String productId = request.getParameter("id");
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();

    if (productId == null || productId.length() == 0) {
        out.print("No product specified");
    } else {
        try (Connection con = DriverManager.getConnection(urlForLoadData, uid, pw);) {
            PreparedStatement pstmt = con.prepareStatement("select *" +
                    "from orders.dbo.product\n" +
                    "where productId = ?;");
            pstmt.setString(1, productId);
            ResultSet rst = pstmt.executeQuery();
            rst.next();{}{
            String imageUrl = rst.getString("productImageURL");
            double price = rst.getDouble("productPrice");
            String productName = rst.getString("productName");

            out.print("<h1>" + productName + "</h1>");

            //image
            if (imageUrl != null) {
                //If there is a productImageURL, display using IMG tag
                out.print("<img src=\"" + imageUrl + "\">");
            }
            //Try retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
            PreparedStatement imageObj = con.prepareStatement("SELECT productImage FROM Product WHERE productId = ?");
            imageObj.setString(1, productId);
            ResultSet imageObjRes = pstmt.executeQuery();
            imageObjRes.next();
            if (imageObjRes.getString("productImage") != null) {
                out.print("<img src=\"displayImage.jsp?id=" + productId + "\">");
            }

            //properties
            out.print("<h3>id: " + productId + "</h3>");
            out.print("<h3>price: " + currencyFormatter.format(price) + "</h3>");

            //url
            out.print("<h3><a href=\"addcart.jsp?id=" + productId + "&amp;name=" + productName + "&amp;price=" + price + "\">Add to Cart</a></h3>");
            out.print("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3>");

        } catch (Exception e) {
            out.print(e);
        }


    }

%>

</body>
</html>

