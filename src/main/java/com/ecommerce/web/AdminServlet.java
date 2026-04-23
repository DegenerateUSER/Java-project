package com.ecommerce.web;

import com.ecommerce.model.User;
import com.ecommerce.service.AdminService;
import com.ecommerce.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req, resp)) {
            return;
        }

        req.setAttribute("salesSummary", adminService.getSalesSummary());
        req.setAttribute("topProducts", adminService.getTopProducts());
        req.setAttribute("activeUsers", adminService.getUserActivityCount());
        req.setAttribute("products", adminService.getAllProducts());
        req.setAttribute("users", adminService.getAllUsers());
        req.getRequestDispatcher("/views/admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!isAdmin(req, resp)) {
            return;
        }

        String action = req.getParameter("action");
        try {
            if ("createProduct".equals(action)) {
                String name = req.getParameter("name");
                String category = req.getParameter("category");
                BigDecimal price = new BigDecimal(req.getParameter("price"));
                Integer stock = Integer.valueOf(req.getParameter("stock"));
                adminService.createProduct(name, price, stock, category);
            } else if ("deleteProduct".equals(action)) {
                Long productId = Long.valueOf(req.getParameter("productId"));
                adminService.deleteProduct(productId);
            } else if ("updateUserRole".equals(action)) {
                Long targetUserId = Long.valueOf(req.getParameter("targetUserId"));
                String role = req.getParameter("role");
                adminService.updateUserRole(targetUserId, role);
            }
        } catch (RuntimeException ex) {
            req.getSession(true).setAttribute("adminError", ex.getMessage());
        }

        resp.sendRedirect("admin");
    }

    private boolean isAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long userId = SessionUtil.getUserId(req);
        if (userId == null) {
            resp.sendRedirect("login");
            return false;
        }

        User user = authService.findById(userId).orElse(null);
        if (user == null || !"ADMIN".equals(user.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return false;
        }
        return true;
    }
}
