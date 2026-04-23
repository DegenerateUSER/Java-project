package com.ecommerce.service;

public final class ValidationUtil {

    private ValidationUtil() {
    }

    public static void requireNonBlank(String value, String message) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(message);
        }
    }

    public static void requireEmail(String email) {
        requireNonBlank(email, "Email is required");
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            throw new IllegalArgumentException("Enter a valid email address");
        }
    }

    public static void requireMinLength(String value, int minLength, String message) {
        requireNonBlank(value, message);
        if (value.length() < minLength) {
            throw new IllegalArgumentException(message);
        }
    }
}
