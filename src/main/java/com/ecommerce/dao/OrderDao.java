package com.ecommerce.dao;

import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class OrderDao extends BaseDao {

    public Order save(Order order) {
        return executeInTransaction(session -> {
            session.persist(order);
            return order;
        });
    }

    public List<Order> findByUser(User user) {
        return executeInTransaction(session -> {
            Query<Order> query = session.createQuery(
                    "select distinct o from Order o "
                            + "left join fetch o.user "
                            + "left join fetch o.items i "
                            + "left join fetch i.product "
                            + "where o.user = :user order by o.date desc", Order.class);
            query.setParameter("user", user);
            return query.list();
        });
    }

    public List<Order> findAll() {
        return executeInTransaction(
                session -> session.createQuery(
                                "select distinct o from Order o "
                                        + "left join fetch o.user "
                                        + "left join fetch o.items i "
                                        + "left join fetch i.product "
                                        + "order by o.date desc",
                                Order.class)
                        .list());
    }

    public Optional<Order> findByIdAndUser(Long orderId, User user) {
        return executeInTransaction(session -> {
            Query<Order> query = session.createQuery(
                    "select distinct o from Order o "
                            + "left join fetch o.user "
                            + "left join fetch o.items i "
                            + "left join fetch i.product "
                            + "where o.orderId = :orderId and o.user = :user", Order.class);
            query.setParameter("orderId", orderId);
            query.setParameter("user", user);
            return query.uniqueResultOptional();
        });
    }
}
