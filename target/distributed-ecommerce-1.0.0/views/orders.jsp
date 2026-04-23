<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Order" %>
<%@ page import="com.ecommerce.model.OrderItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<main class="page-shell">
    <section class="hero reveal">
        <p class="eyebrow">Orders</p>
        <h1>Track your complete order history</h1>
        <p class="hero-copy">See item-level details and open printable invoices for each order.</p>
        <nav class="nav-links">
            <a href="products">Back to Products</a>
            <a href="cart">View Cart</a>
        </nav>
    </section>

    <section class="card reveal">
        <h2>Order History</h2>
        <% if (request.getAttribute("orderError") != null) { %>
        <p class="alert alert-error"><%= request.getAttribute("orderError") %></p>
        <% } %>

        <% if (orders != null && !orders.isEmpty()) {
            for (Order order : orders) {
        %>
        <article class="card order-card" style="margin-top: 0.9rem;">
            <div class="split">
                <h3>Order #<%= order.getOrderId() %></h3>
                <span class="pill"><%= order.getStatus() %></span>
            </div>
            <p class="muted">Placed on <%= order.getDate() %></p>
            <p><a class="btn btn-ghost" href="invoice?orderId=<%= order.getOrderId() %>">Open Invoice</a></p>
            <ul class="list-clean">
                <% for (OrderItem item : order.getItems()) { %>
                <li>
                    <span><%= item.getProduct().getName() %></span>
                    <span><%= item.getQuantity() %> x Rs. <%= item.getPrice() %></span>
                </li>
                <% } %>
            </ul>
        </article>
        <% }
        } else { %>
        <p class="empty-state">No orders yet. Place your first order from the cart.</p>
        <% } %>
    </section>
</main>
</body>
</html>
