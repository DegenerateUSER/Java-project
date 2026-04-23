<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ecommerce.model.Order" %>
<%@ page import="com.ecommerce.model.OrderItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Invoice</title>
</head>
<body>
<%
    Order order = (Order) request.getAttribute("order");
    BigDecimal total = BigDecimal.ZERO;
%>
<h2>Invoice - Order #<%= order.getOrderId() %></h2>
<p>Status: <strong><%= order.getStatus() %></strong></p>
<p>Date: <%= order.getDate() %></p>
<p>Customer: <%= order.getUser().getName() %> (<%= order.getUser().getEmail() %>)</p>
<hr>
<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>Product</th>
        <th>Qty</th>
        <th>Unit Price</th>
        <th>Line Total</th>
    </tr>
    <% for (OrderItem item : order.getItems()) {
        BigDecimal lineTotal = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
        total = total.add(lineTotal);
    %>
    <tr>
        <td><%= item.getProduct().getName() %></td>
        <td><%= item.getQuantity() %></td>
        <td>Rs. <%= item.getPrice() %></td>
        <td>Rs. <%= lineTotal %></td>
    </tr>
    <% } %>
</table>
<p><strong>Grand Total: Rs. <%= total %></strong></p>
<p>
    <button onclick="window.print()">Print Invoice</button>
    <a href="orders">Back to Orders</a>
</p>
</body>
</html>
