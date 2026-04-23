<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<main class="page-shell narrow">
    <section class="hero reveal">
        <p class="eyebrow">Welcome Back</p>
        <h1>Login to continue shopping</h1>
        <p class="hero-copy">Access products, your cart, and order history from a single dashboard.</p>
    </section>

    <section class="card reveal">
        <h2>User Login</h2>
        <% if (request.getAttribute("error") != null) { %>
        <p class="alert alert-error"><%= request.getAttribute("error") %></p>
        <% } %>

        <form class="stack-form" method="post" action="login">
            <label>
                Email
                <input type="email" name="email" required>
            </label>
            <label>
                Password
                <input type="password" name="password" required>
            </label>
            <button class="btn" type="submit">Login</button>
        </form>

        <p class="form-foot">New user? <a href="register">Create an account</a></p>
    </section>
</main>
</body>
</html>
