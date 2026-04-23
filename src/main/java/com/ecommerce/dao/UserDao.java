package com.ecommerce.dao;

import com.ecommerce.model.User;
import org.hibernate.query.MutationQuery;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class UserDao extends BaseDao {

    public User save(User user) {
        return executeInTransaction(session -> {
            session.persist(user);
            return user;
        });
    }

    public Optional<User> findByEmail(String email) {
        return executeInTransaction(session -> {
            Query<User> query = session.createQuery("from User where email = :email", User.class);
            query.setParameter("email", email);
            return query.uniqueResultOptional();
        });
    }

    public Optional<User> findById(Long id) {
        return executeInTransaction(session -> Optional.ofNullable(session.get(User.class, id)));
    }

    public List<User> findAll() {
        return executeInTransaction(session -> session.createQuery("from User", User.class).list());
    }

    public void updateRole(Long userId, String role) {
        executeInTransaction(session -> {
            MutationQuery query = session.createMutationQuery("update User u set u.role = :role where u.userId = :userId");
            query.setParameter("role", role);
            query.setParameter("userId", userId);
            query.executeUpdate();
            return null;
        });
    }
}
