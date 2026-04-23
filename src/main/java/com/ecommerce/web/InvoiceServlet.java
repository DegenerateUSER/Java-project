package com.ecommerce.web;

import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import com.ecommerce.service.AuthService;
import com.ecommerce.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {

    private final AuthService authService = new AuthService();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long userId = SessionUtil.getUserId(req);
        if (userId == null) {
            resp.sendRedirect("login");
            return;
        }

        User user = authService.findById(userId).orElse(null);
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        try {
            Long orderId = Long.valueOf(req.getParameter("orderId"));
            Optional<Order> order = orderService.getOrderForUser(orderId, user);
            if (order.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Invoice not found");
                return;
            }

            req.setAttribute("order", order.get());
            req.getRequestDispatcher("/views/invoice.jsp").forward(req, resp);
        } catch (NumberFormatException ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID");
        }
    }
}
