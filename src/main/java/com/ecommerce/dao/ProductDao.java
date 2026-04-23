package com.ecommerce.dao;

import com.ecommerce.model.Product;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class ProductDao extends BaseDao {

    public Product save(Product product) {
        return executeInTransaction(session -> {
            session.persist(product);
            return product;
        });
    }

    public List<Product> findAll() {
        return executeInTransaction(
                session -> session.createQuery("from com.ecommerce.model.Product", Product.class).list());
    }

    public List<Product> search(String keyword) {
        return executeInTransaction(session -> {
            Query<Product> query = session.createQuery(
                    "from com.ecommerce.model.Product p where lower(p.name) like :q or lower(p.category) like :q",
                    Product.class);
            query.setParameter("q", "%" + keyword.toLowerCase() + "%");
            return query.list();
        });
    }

    public Optional<Product> findById(Long id) {
        return executeInTransaction(session -> Optional.ofNullable(session.get(Product.class, id)));
    }

    public Product update(Product product) {
        return executeInTransaction(session -> {
            session.merge(product);
            return product;
        });
    }

    public void delete(Long productId) {
        executeInTransaction(session -> {
            Product product = session.get(Product.class, productId);
            if (product != null) {
                session.remove(product);
            }
            return null;
        });
    }
}
