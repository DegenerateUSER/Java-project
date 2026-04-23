package com.ecommerce.service;

import com.ecommerce.dao.ProductDao;
import com.ecommerce.model.Product;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public class ProductService {

    private final ProductDao productDao = new ProductDao();

    public Product create(String name, BigDecimal price, Integer stock, String category) {
        ValidationUtil.requireNonBlank(name, "Product name is required");
        ValidationUtil.requireNonBlank(category, "Category is required");
        if (price == null || price.signum() <= 0) {
            throw new IllegalArgumentException("Price must be greater than zero");
        }
        if (stock == null || stock < 0) {
            throw new IllegalArgumentException("Stock cannot be negative");
        }

        Product product = new Product();
        product.setName(name.trim());
        product.setPrice(price);
        product.setStock(stock);
        product.setCategory(category.trim());
        return productDao.save(product);
    }

    public List<Product> list(String query) {
        if (query == null || query.isBlank()) {
            return productDao.findAll();
        }
        return productDao.search(query);
    }

    public Optional<Product> findById(Long id) {
        return productDao.findById(id);
    }
}
