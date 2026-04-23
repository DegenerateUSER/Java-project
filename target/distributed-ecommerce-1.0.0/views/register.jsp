<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<main class="page-shell narrow">
    <section class="hero reveal">
        <p class="eyebrow">New Account</p>
        <h1>Create your profile in seconds</h1>
        <p class="hero-copy">Register once, then browse, add items to cart, and place orders with ease.</p>
    </section>

    <section class="card reveal">
        <h2>User Registration</h2>
        <% if (request.getAttribute("error") != null) { %>
        <p class="alert alert-error"><%= request.getAttribute("error") %></p>
        <% } %>

        <form class="stack-form" method="post" action="register">
            <label>
                Full Name
                <input type="text" name="name" required>
            </label>
            <label>
                Email
                <input type="email" name="email" required>
            </label>
            <label>
                Password
                <input type="password" name="password" required>
            </label>
            <button class="btn" type="submit">Register</button>
        </form>

        <p class="form-foot">Already have an account? <a href="login">Login</a></p>
    </section>
</main>
</body>
</html>
