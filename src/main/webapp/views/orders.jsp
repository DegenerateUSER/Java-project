<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Order" %>
<%@ page import="com.ecommerce.model.OrderItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Orders</title>
</head>
<body>
<h2>Order History</h2>
<p>
    <a href="products">Back to Products</a> |
    <a href="cart">View Cart</a>
</p>
<% if (request.getAttribute("orderError") != null) { %>
<p style="color:red;"><%= request.getAttribute("orderError") %></p>
<% } %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders != null && !orders.isEmpty()) {
        for (Order order : orders) {
%>
<div>
    <p><strong>Order #<%= order.getOrderId() %></strong> - <%= order.getStatus() %> - <%= order.getDate() %></p>
    <p><a href="invoice?orderId=<%= order.getOrderId() %>">View Invoice</a></p>
    <ul>
        <% for (OrderItem item : order.getItems()) { %>
        <li><%= item.getProduct().getName() %> x <%= item.getQuantity() %> @ Rs. <%= item.getPrice() %></li>
        <% } %>
    </ul>
</div>
<hr>
<%
        }
    } else {
%>
<p>No orders yet.</p>
<%
    }
%>
</body>
</html>
