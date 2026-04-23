package com.ecommerce.dao;

import com.ecommerce.model.CartItem;
import com.ecommerce.model.User;
import org.hibernate.query.MutationQuery;
import org.hibernate.query.Query;

import java.util.List;

public class CartDao extends BaseDao {

    public CartItem save(CartItem item) {
        return executeInTransaction(session -> {
            session.persist(item);
            return item;
        });
    }

    public List<CartItem> findByUser(User user) {
        return executeInTransaction(session -> {
            Query<CartItem> query = session.createQuery(
                    "select c from com.ecommerce.model.CartItem c join fetch c.product where c.user = :user",
                    CartItem.class);
            query.setParameter("user", user);
            return query.list();
        });
    }

    public void delete(CartItem item) {
        executeInTransaction(session -> {
            session.remove(session.contains(item) ? item : session.merge(item));
            return null;
        });
    }

    public void clearByUser(User user) {
        executeInTransaction(session -> {
            MutationQuery query =
                    session.createMutationQuery("delete from com.ecommerce.model.CartItem c where c.user = :user");
            query.setParameter("user", user);
            query.executeUpdate();
            return null;
        });
    }
}
