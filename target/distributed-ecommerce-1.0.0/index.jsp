<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Distributed E-Commerce</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<main class="page-shell">
    <section class="hero reveal">
        <p class="eyebrow">Distributed Commerce</p>
        <h1>Readable shopping, checkout, and admin workflows in one place.</h1>
        <p class="hero-copy">
            Built using JSP + Servlets, Hibernate ORM, PostgreSQL, and a mock RMI payment gateway.
        </p>
    </section>

    <section class="card reveal">
        <h2>Get Started</h2>
        <p class="card-subtitle">Choose a starting point based on what you want to do.</p>
        <div class="action-row">
            <a class="btn" href="register">Create Account</a>
            <a class="btn btn-secondary" href="login">Login</a>
            <a class="btn btn-ghost" href="products">Browse Products</a>
        </div>
    </section>
</main>
</body>
</html>
