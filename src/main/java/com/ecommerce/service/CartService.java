package com.ecommerce.service;

import com.ecommerce.dao.CartDao;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;
import com.ecommerce.model.User;

import java.util.List;

public class CartService {

    private final CartDao cartDao = new CartDao();

    public CartItem addToCart(User user, Product product, int quantity) {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be positive");
        }
        if (product.getStock() == null || product.getStock() <= 0) {
            throw new IllegalArgumentException("Product is out of stock");
        }
        if (quantity > product.getStock()) {
            throw new IllegalArgumentException("Requested quantity exceeds available stock");
        }

        CartItem item = new CartItem();
        item.setUser(user);
        item.setProduct(product);
        item.setQuantity(quantity);
        return cartDao.save(item);
    }

    public List<CartItem> getCart(User user) {
        return cartDao.findByUser(user);
    }

    public void clear(User user) {
        cartDao.clearByUser(user);
    }
}
