package com.ecommerce.service;

import com.ecommerce.dao.UserDao;
import com.ecommerce.model.User;

import java.util.Optional;

public class AuthService {

    private final UserDao userDao = new UserDao();

    public User register(String name, String email, String password) {
        ValidationUtil.requireNonBlank(name, "Name is required");
        ValidationUtil.requireEmail(email);
        ValidationUtil.requireMinLength(password, 8, "Password must be at least 8 characters");

        String normalizedEmail = email.trim().toLowerCase();

        Optional<User> existing = userDao.findByEmail(normalizedEmail);
        if (existing.isPresent()) {
            throw new IllegalArgumentException("Email is already registered");
        }

        User user = new User();
        user.setName(name.trim());
        user.setEmail(normalizedEmail);
        user.setPassword(PasswordUtil.hash(password));
        return userDao.save(user);
    }

    public Optional<User> login(String email, String password) {
        ValidationUtil.requireEmail(email);
        ValidationUtil.requireNonBlank(password, "Password is required");

        String normalizedEmail = email.trim().toLowerCase();

        return userDao.findByEmail(normalizedEmail)
                .filter(user -> PasswordUtil.matches(password, user.getPassword()));
    }

    public Optional<User> findById(Long id) {
        return userDao.findById(id);
    }
}
