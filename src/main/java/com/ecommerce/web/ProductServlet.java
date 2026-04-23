package com.ecommerce.web;

import com.ecommerce.model.Product;
import com.ecommerce.model.User;
import com.ecommerce.service.AuthService;
import com.ecommerce.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long userId = SessionUtil.getUserId(req);
        if (userId == null) {
            resp.sendRedirect("login");
            return;
        }

        String q = req.getParameter("q");
        List<Product> products = productService.list(q);
        Optional<User> user = authService.findById(userId);

        req.setAttribute("products", products);
        req.setAttribute("user", user.orElse(null));
        req.getRequestDispatcher("/views/products.jsp").forward(req, resp);
    }
}
