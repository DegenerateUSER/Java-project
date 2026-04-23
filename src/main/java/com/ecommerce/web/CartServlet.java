package com.ecommerce.web;

import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;
import com.ecommerce.model.User;
import com.ecommerce.service.AuthService;
import com.ecommerce.service.CartService;
import com.ecommerce.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartService cartService = new CartService();
    private final ProductService productService = new ProductService();
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = requireUser(req, resp);
        if (user == null) {
            return;
        }

        Object cartError = req.getSession().getAttribute("cartError");
        if (cartError != null) {
            req.setAttribute("cartError", cartError);
            req.getSession().removeAttribute("cartError");
        }

        List<CartItem> cart = cartService.getCart(user);
        req.setAttribute("cartItems", cart);
        req.getRequestDispatcher("/views/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = requireUser(req, resp);
        if (user == null) {
            return;
        }

        try {
            Long productId = Long.valueOf(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            Optional<Product> product = productService.findById(productId);
            if (product.isEmpty()) {
                req.getSession().setAttribute("cartError", "Selected product was not found");
                resp.sendRedirect("products");
                return;
            }

            cartService.addToCart(user, product.get(), quantity);
        } catch (NumberFormatException ex) {
            req.getSession().setAttribute("cartError", "Invalid product selection or quantity");
        } catch (IllegalArgumentException ex) {
            req.getSession().setAttribute("cartError", ex.getMessage());
        }

        resp.sendRedirect("cart");
    }

    private User requireUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long userId = SessionUtil.getUserId(req);
        if (userId == null) {
            resp.sendRedirect("login");
            return null;
        }
        return authService.findById(userId).orElse(null);
    }
}
