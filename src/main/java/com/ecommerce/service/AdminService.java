package com.ecommerce.service;

import com.ecommerce.dao.ProductDao;
import com.ecommerce.dao.UserDao;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import com.ecommerce.model.Product;
import com.ecommerce.model.User;

import java.math.BigDecimal;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class AdminService {

    private final OrderService orderService = new OrderService();
    private final ProductDao productDao = new ProductDao();
    private final UserDao userDao = new UserDao();
    private final ProductService productService = new ProductService();

    public BigDecimal getSalesSummary() {
        return orderService.getAllOrders().stream()
                .flatMap(order -> order.getItems().stream())
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public List<Map.Entry<String, Integer>> getTopProducts() {
        Map<String, Integer> aggregate = new HashMap<>();
        for (Order order : orderService.getAllOrders()) {
            for (OrderItem item : order.getItems()) {
                aggregate.merge(item.getProduct().getName(), item.getQuantity(), Integer::sum);
            }
        }

        return aggregate.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue(Comparator.reverseOrder()))
                .limit(5)
                .collect(Collectors.toList());
    }

    public long getUserActivityCount() {
        return orderService.getAllOrders().stream()
                .map(order -> order.getUser().getUserId())
                .distinct()
                .count();
    }

    public List<Product> getAllProducts() {
        return productDao.findAll();
    }

    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    public Product createProduct(String name, BigDecimal price, Integer stock, String category) {
        return productService.create(name, price, stock, category);
    }

    public void deleteProduct(Long productId) {
        productDao.delete(productId);
    }

    public void updateUserRole(Long userId, String role) {
        if (!"USER".equals(role) && !"ADMIN".equals(role)) {
            throw new IllegalArgumentException("Role must be USER or ADMIN");
        }
        userDao.updateRole(userId, role);
    }
}
