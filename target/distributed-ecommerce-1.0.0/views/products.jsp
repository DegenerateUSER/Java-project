<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Product" %>
<%@ page import="com.ecommerce.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
</head>
<body>
<h2>Product Catalog</h2>
<form method="get" action="products">
    <input type="text" name="q" placeholder="Search by name/category">
    <button type="submit">Search</button>
</form>
<p>
    <a href="cart">View Cart</a> |
    <a href="orders">My Orders</a> |
    <% if (request.getAttribute("user") != null && "ADMIN".equals(((User) request.getAttribute("user")).getRole())) { %>
    <a href="admin">Admin Dashboard</a> |
    <% } %>
    <a href="logout">Logout</a>
</p>
<hr>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    if (products != null) {
        for (Product p : products) {
%>
<div>
    <strong><%= p.getName() %></strong>
    (<%= p.getCategory() %>) - Rs. <%= p.getPrice() %> - Stock: <%= p.getStock() %>
    <form method="post" action="cart">
        <input type="hidden" name="productId" value="<%= p.getProductId() %>">
        <input type="number" name="quantity" min="1" value="1" required>
        <button type="submit">Add to Cart</button>
    </form>
</div>
<hr>
<%
        }
    }
%>
</body>
</html>
