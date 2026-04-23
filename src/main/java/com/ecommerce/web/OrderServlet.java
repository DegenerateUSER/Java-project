package com.ecommerce.web;

import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import com.ecommerce.service.AuthService;
import com.ecommerce.service.CartService;
import com.ecommerce.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();
    private final CartService cartService = new CartService();
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = requireUser(req, resp);
        if (user == null) {
            return;
        }

        Object orderError = req.getSession().getAttribute("orderError");
        if (orderError != null) {
            req.setAttribute("orderError", orderError);
            req.getSession().removeAttribute("orderError");
        }

        List<Order> orders = orderService.getUserOrders(user);
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = requireUser(req, resp);
        if (user == null) {
            return;
        }

        try {
            List<CartItem> cartItems = cartService.getCart(user);
            orderService.placeOrder(user, cartItems);
            cartService.clear(user);
            resp.sendRedirect("orders");
        } catch (RuntimeException ex) {
            req.getSession().setAttribute("orderError", ex.getMessage());
            resp.sendRedirect("cart");
        }
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
