package com.ecommerce.config;

import com.ecommerce.dao.UserDao;
import com.ecommerce.model.User;
import com.ecommerce.rmi.RmiPaymentServer;
import com.ecommerce.service.PasswordUtil;
import com.ecommerce.service.ProductService;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.math.BigDecimal;

@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        RmiPaymentServer.start();
        seedAdminUser();
        seedProducts();
    }

    private void seedAdminUser() {
        UserDao userDao = new UserDao();
        if (userDao.findByEmail("admin@ecommerce.local").isPresent()) {
            return;
        }

        User admin = new User();
        admin.setName("System Admin");
        admin.setEmail("admin@ecommerce.local");
        admin.setPassword(PasswordUtil.hash("Admin@123"));
        admin.setRole("ADMIN");
        userDao.save(admin);
    }

    private void seedProducts() {
        ProductService productService = new ProductService();
        if (!productService.list(null).isEmpty()) {
            return;
        }

        productService.create("Laptop", new BigDecimal("65000"), 10, "Electronics");
        productService.create("Office Chair", new BigDecimal("7000"), 20, "Furniture");
        productService.create("Wireless Mouse", new BigDecimal("1200"), 50, "Accessories");
    }
}
