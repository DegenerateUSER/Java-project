<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Product" %>
<%@ page import="com.ecommerce.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    User currentUser = (User) request.getAttribute("user");
    String q = request.getParameter("q");
%>
<main class="page-shell">
    <section class="hero reveal">
        <p class="eyebrow">Catalog</p>
        <h1>Discover products with clear pricing and stock details</h1>
        <p class="hero-copy">Search by name or category, then add quantities directly to your cart.</p>
        <nav class="nav-links">
            <a href="cart">View Cart</a>
            <a href="orders">My Orders</a>
            <% if (currentUser != null && "ADMIN".equals(currentUser.getRole())) { %>
            <a href="admin">Admin Dashboard</a>
            <% } %>
            <a href="logout">Logout</a>
        </nav>
    </section>

    <section class="card reveal">
        <h2>Find Products</h2>
        <form class="inline-form" method="get" action="products">
            <label>
                Search
                <input type="text" name="q" value="<%= q == null ? "" : q %>" placeholder="name or category">
            </label>
            <button class="btn" type="submit">Search</button>
            <a class="btn btn-ghost" href="products">Reset</a>
        </form>
    </section>

    <% if (products != null && !products.isEmpty()) { %>
    <section class="grid-cards">
        <% for (Product p : products) { %>
        <article class="card product-card reveal">
            <div class="product-head">
                <h3><%= p.getName() %></h3>
                <span class="pill"><%= p.getCategory() %></span>
            </div>
            <p class="price">Rs. <%= p.getPrice() %></p>
            <p class="muted">Stock Available: <%= p.getStock() %></p>
            <form class="inline-form" method="post" action="cart">
                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                <label>
                    Quantity
                    <input type="number" name="quantity" min="1" value="1" required>
                </label>
                <button class="btn" type="submit">Add to Cart</button>
            </form>
        </article>
        <% } %>
    </section>
    <% } else { %>
    <section class="card reveal">
        <p class="empty-state">No matching products found. Try another search.</p>
    </section>
    <% } %>
</main>
</body>
</html>
