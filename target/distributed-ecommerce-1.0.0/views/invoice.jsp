<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ecommerce.model.Order" %>
<%@ page import="com.ecommerce.model.OrderItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<%
    Order order = (Order) request.getAttribute("order");
    BigDecimal total = BigDecimal.ZERO;
%>
<main class="page-shell">
    <section class="hero reveal">
        <p class="eyebrow">Invoice</p>
        <% if (order != null) { %>
        <h1>Order #<%= order.getOrderId() %></h1>
        <p class="hero-copy">Printable invoice with line items and totals.</p>
        <% } else { %>
        <h1>Invoice Not Available</h1>
        <p class="hero-copy">The requested invoice could not be found.</p>
        <% } %>
    </section>

    <section class="card reveal">
        <% if (order != null) { %>
        <div class="summary-grid">
            <div class="stat">
                <span class="muted">Status</span>
                <strong><%= order.getStatus() %></strong>
            </div>
            <div class="stat">
                <span class="muted">Date</span>
                <strong><%= order.getDate() %></strong>
            </div>
            <div class="stat">
                <span class="muted">Customer</span>
                <strong><%= order.getUser().getName() %></strong>
            </div>
        </div>

        <p class="muted" style="margin-top: 0.85rem;">Email: <%= order.getUser().getEmail() %></p>

        <div class="data-table-wrap" style="margin-top: 1rem;">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Product</th>
                    <th>Qty</th>
                    <th>Unit Price</th>
                    <th>Line Total</th>
                </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>
        </div>

        <div class="split" style="margin-top: 0.9rem;">
            <h3>Grand Total</h3>
            <h3>Rs. <%= total %></h3>
        </div>

        <div class="action-row no-print" style="margin-top: 1rem;">
            <button class="btn" onclick="window.print()" type="button">Print Invoice</button>
            <a class="btn btn-ghost" href="orders">Back to Orders</a>
        </div>
        <% } else { %>
        <p class="empty-state">Unable to load invoice details for this request.</p>
        <div class="action-row" style="margin-top: 1rem;">
            <a class="btn btn-ghost" href="orders">Back to Orders</a>
        </div>
        <% } %>
    </section>
</main>
</body>
</html>
