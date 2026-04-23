<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<main class="page-shell narrow">
    <section class="hero reveal">
        <p class="eyebrow">Error</p>
        <h1>Something went wrong</h1>
        <p class="hero-copy">An unexpected issue occurred while processing your request.</p>
    </section>

    <section class="card reveal">
        <p class="empty-state">Please try again, or return to the catalog.</p>
        <div class="action-row" style="margin-top: 0.95rem;">
            <a class="btn btn-ghost" href="products">Back to Products</a>
        </div>
    </section>
</main>
</body>
</html>
