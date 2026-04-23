<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ecommerce.model.Product" %>
<%@ page import="com.ecommerce.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<%
    Object adminError = session.getAttribute("adminError");
    List<Map.Entry<String, Integer>> topProducts =
            (List<Map.Entry<String, Integer>>) request.getAttribute("topProducts");
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<User> users = (List<User>) request.getAttribute("users");
%>
<main class="page-shell">
    <section class="hero reveal">
        <p class="eyebrow">Admin</p>
        <h1>Operations dashboard</h1>
        <p class="hero-copy">Manage catalog, user roles, and key business metrics from one control panel.</p>
        <nav class="nav-links">
            <a href="products">Back to Products</a>
        </nav>
    </section>

    <section class="card reveal">
        <h2>Business Snapshot</h2>
        <% if (adminError != null) { %>
        <p class="alert alert-error"><%= adminError %></p>
        <% session.removeAttribute("adminError"); %>
        <% } %>

        <div class="summary-grid" style="margin-top: 0.8rem;">
            <div class="stat">
                <span class="muted">Sales Summary</span>
                <strong>Rs. <%= request.getAttribute("salesSummary") %></strong>
            </div>
            <div class="stat">
                <span class="muted">Active Users</span>
                <strong><%= request.getAttribute("activeUsers") %></strong>
            </div>
            <div class="stat">
                <span class="muted">Products in Catalog</span>
                <strong><%= products == null ? 0 : products.size() %></strong>
            </div>
        </div>
    </section>

    <section class="card reveal">
        <h2>Top Products</h2>
        <% if (topProducts != null && !topProducts.isEmpty()) { %>
        <ul class="list-clean" style="margin-top: 0.85rem;">
            <% for (Map.Entry<String, Integer> entry : topProducts) { %>
            <li>
                <span><%= entry.getKey() %></span>
                <span>Sold: <%= entry.getValue() %></span>
            </li>
            <% } %>
        </ul>
        <% } else { %>
        <p class="empty-state" style="margin-top: 0.85rem;">No product sales data available yet.</p>
        <% } %>
    </section>

    <section class="card reveal">
        <h2>Manage Products</h2>
        <form class="inline-form" method="post" action="admin" style="margin-top: 0.85rem;">
            <input type="hidden" name="action" value="createProduct">
            <label>
                Name
                <input type="text" name="name" required>
            </label>
            <label>
                Category
                <input type="text" name="category" required>
            </label>
            <label>
                Price
                <input type="number" name="price" step="0.01" min="0.01" required>
            </label>
            <label>
                Stock
                <input type="number" name="stock" min="0" required>
            </label>
            <button class="btn" type="submit">Add Product</button>
        </form>

        <div class="data-table-wrap" style="margin-top: 1rem;">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <% if (products != null) {
                    for (Product product : products) {
                %>
                <tr>
                    <td><%= product.getProductId() %></td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getCategory() %></td>
                    <td>Rs. <%= product.getPrice() %></td>
                    <td><%= product.getStock() %></td>
                    <td>
                        <form method="post" action="admin" onsubmit="return confirm('Delete this product?');">
                            <input type="hidden" name="action" value="deleteProduct">
                            <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                            <button class="btn btn-danger" type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
                <% }
                } %>
                </tbody>
            </table>
        </div>
    </section>

    <section class="card reveal">
        <h2>Manage Users</h2>
        <div class="data-table-wrap" style="margin-top: 0.85rem;">
            <table class="data-table">
                <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Update Role</th>
                </tr>
                </thead>
                <tbody>
                <% if (users != null) {
                    for (User user : users) {
                %>
                <tr>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getRole() %></td>
                    <td>
                        <form class="inline-form" method="post" action="admin">
                            <input type="hidden" name="action" value="updateUserRole">
                            <input type="hidden" name="targetUserId" value="<%= user.getUserId() %>">
                            <label>
                                Role
                                <select name="role">
                                    <option value="USER" <%= "USER".equals(user.getRole()) ? "selected" : "" %>>USER</option>
                                    <option value="ADMIN" <%= "ADMIN".equals(user.getRole()) ? "selected" : "" %>>ADMIN</option>
                                </select>
                            </label>
                            <button class="btn btn-secondary" type="submit">Save</button>
                        </form>
                    </td>
                </tr>
                <% }
                } %>
                </tbody>
            </table>
        </div>
    </section>
</main>
</body>
</html>
