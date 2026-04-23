<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ecommerce.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    BigDecimal total = BigDecimal.ZERO;
%>
<main class="page-shell">
    <section class="hero reveal">
        <p class="eyebrow">Cart</p>
        <h1>Review your cart before checkout</h1>
        <p class="hero-copy">Confirm quantities and totals, then place your order.</p>
        <nav class="nav-links">
            <a href="products">Back to Products</a>
            <a href="orders">My Orders</a>
        </nav>
    </section>

    <section class="card reveal">
        <h2>Your Cart</h2>

        <% if (request.getAttribute("cartError") != null) { %>
        <p class="alert alert-error"><%= request.getAttribute("cartError") %></p>
        <% } %>

        <% if (session.getAttribute("orderError") != null) { %>
        <p class="alert alert-error"><%= session.getAttribute("orderError") %></p>
        <% session.removeAttribute("orderError"); %>
        <% } %>

        <% if (cartItems != null && !cartItems.isEmpty()) { %>
        <div class="data-table-wrap">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Product</th>
                    <th>Unit Price</th>
                    <th>Qty</th>
                    <th>Line Total</th>
                </tr>
                </thead>
                <tbody>
                <% for (CartItem item : cartItems) {
                    BigDecimal lineTotal = item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
                    total = total.add(lineTotal);
                %>
                <tr>
                    <td><%= item.getProduct().getName() %></td>
                    <td>Rs. <%= item.getProduct().getPrice() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td>Rs. <%= lineTotal %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <div class="card" style="margin-top: 1rem;">
            <div class="split">
                <h3>Total Amount</h3>
                <h3>Rs. <%= total %></h3>
            </div>
            <form style="margin-top: 0.8rem;" method="post" action="orders">
                <button class="btn" type="submit">Place Order</button>
            </form>
        </div>
        <% } else { %>
        <p class="empty-state">Your cart is empty. Add products from the catalog first.</p>
        <% } %>
    </section>
</main>
</body>
</html>
