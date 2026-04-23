<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ecommerce.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
</head>
<body>
<h2>Your Cart</h2>
<p>
    <a href="products">Back to Products</a> |
    <a href="orders">My Orders</a>
</p>
<% if (request.getAttribute("cartError") != null) { %>
<p style="color:red;"><%= request.getAttribute("cartError") %></p>
<% } %>
<% if (session.getAttribute("orderError") != null) { %>
<p style="color:red;"><%= session.getAttribute("orderError") %></p>
<% session.removeAttribute("orderError"); %>
<% } %>
<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    BigDecimal total = BigDecimal.ZERO;
    if (cartItems != null && !cartItems.isEmpty()) {
        for (CartItem item : cartItems) {
            BigDecimal lineTotal = item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            total = total.add(lineTotal);
%>
<div>
    <strong><%= item.getProduct().getName() %></strong> x <%= item.getQuantity() %> = Rs. <%= lineTotal %>
</div>
<%
        }
%>
<hr>
<p><strong>Total: Rs. <%= total %></strong></p>
<form method="post" action="orders">
    <button type="submit">Place Order</button>
</form>
<%
    } else {
%>
<p>Your cart is empty.</p>
<%
    }
%>
</body>
</html>
