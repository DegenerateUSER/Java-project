<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ecommerce.model.Product" %>
<%@ page import="com.ecommerce.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h2>Admin Dashboard</h2>
<p><a href="products">Back to Products</a></p>
<%
    Object adminError = session.getAttribute("adminError");
    if (adminError != null) {
%>
<p style="color:red;"><%= adminError %></p>
<%
        session.removeAttribute("adminError");
    }
%>
<p><strong>Sales Summary:</strong> Rs. <%= request.getAttribute("salesSummary") %></p>
<p><strong>Active Users:</strong> <%= request.getAttribute("activeUsers") %></p>

<h3>Top Products</h3>
<ul>
<%
    List<Map.Entry<String, Integer>> topProducts =
            (List<Map.Entry<String, Integer>>) request.getAttribute("topProducts");
    if (topProducts != null) {
        for (Map.Entry<String, Integer> entry : topProducts) {
%>
    <li><%= entry.getKey() %> - Quantity Sold: <%= entry.getValue() %></li>
<%
        }
    }
%>
</ul>

<h3>Manage Products</h3>
<form method="post" action="admin">
    <input type="hidden" name="action" value="createProduct">
    <label>Name: <input type="text" name="name" required></label>
    <label>Category: <input type="text" name="category" required></label>
    <label>Price: <input type="number" name="price" step="0.01" min="0.01" required></label>
    <label>Stock: <input type="number" name="stock" min="0" required></label>
    <button type="submit">Add Product</button>
</form>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>Product ID</th>
        <th>Name</th>
        <th>Category</th>
        <th>Price</th>
        <th>Stock</th>
        <th>Action</th>
    </tr>
    <%
        if (products != null) {
            for (Product product : products) {
    %>
    <tr>
        <td><%= product.getProductId() %></td>
        <td><%= product.getName() %></td>
        <td><%= product.getCategory() %></td>
        <td><%= product.getPrice() %></td>
        <td><%= product.getStock() %></td>
        <td>
            <form method="post" action="admin" onsubmit="return confirm('Delete this product?');">
                <input type="hidden" name="action" value="deleteProduct">
                <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<h3>Manage Users</h3>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>User ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>Update Role</th>
    </tr>
    <%
        if (users != null) {
            for (User user : users) {
    %>
    <tr>
        <td><%= user.getUserId() %></td>
        <td><%= user.getName() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getRole() %></td>
        <td>
            <form method="post" action="admin">
                <input type="hidden" name="action" value="updateUserRole">
                <input type="hidden" name="targetUserId" value="<%= user.getUserId() %>">
                <select name="role">
                    <option value="USER" <%= "USER".equals(user.getRole()) ? "selected" : "" %>>USER</option>
                    <option value="ADMIN" <%= "ADMIN".equals(user.getRole()) ? "selected" : "" %>>ADMIN</option>
                </select>
                <button type="submit">Save</button>
            </form>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>
</body>
</html>
