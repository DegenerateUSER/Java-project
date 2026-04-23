package com.ecommerce.service;

import com.ecommerce.dao.OrderDao;
import com.ecommerce.dao.ProductDao;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import com.ecommerce.model.OrderStatus;
import com.ecommerce.model.Product;
import com.ecommerce.model.User;
import com.ecommerce.rmi.RmiPaymentClient;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class OrderService {

    private final OrderDao orderDao = new OrderDao();
    private final ProductDao productDao = new ProductDao();
    private final RmiPaymentClient paymentClient = new RmiPaymentClient();

    public Order placeOrder(User user, List<CartItem> cartItems) {
        if (cartItems.isEmpty()) {
            throw new IllegalArgumentException("Cart is empty");
        }

        Order order = new Order();
        order.setUser(user);
        order.setDate(LocalDateTime.now());
        order.setStatus(OrderStatus.PENDING);

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem cartItem : cartItems) {
            Product product = cartItem.getProduct();
            if (product.getStock() == null || cartItem.getQuantity() > product.getStock()) {
                throw new IllegalStateException("Insufficient stock for product: " + product.getName());
            }

            OrderItem item = new OrderItem();
            item.setProduct(product);
            item.setQuantity(cartItem.getQuantity());
            item.setPrice(product.getPrice());
            order.addItem(item);

            BigDecimal lineTotal = product.getPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity()));
            total = total.add(lineTotal);
        }

        boolean paid = paymentClient.processPayment(user.getUserId(), total);
        order.setStatus(paid ? OrderStatus.PAID : OrderStatus.FAILED);

        if (paid) {
            for (CartItem cartItem : cartItems) {
                Product product = cartItem.getProduct();
                product.setStock(product.getStock() - cartItem.getQuantity());
                productDao.update(product);
            }
        }

        return orderDao.save(order);
    }

    public List<Order> getUserOrders(User user) {
        return orderDao.findByUser(user);
    }

    public List<Order> getAllOrders() {
        return orderDao.findAll();
    }

    public Optional<Order> getOrderForUser(Long orderId, User user) {
        return orderDao.findByIdAndUser(orderId, user);
    }
}
