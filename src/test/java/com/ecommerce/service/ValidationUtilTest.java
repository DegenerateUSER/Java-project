package com.ecommerce.service;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class ValidationUtilTest {

    @Test
    void shouldRejectInvalidEmail() {
        Assertions.assertThrows(IllegalArgumentException.class, () -> ValidationUtil.requireEmail("abc"));
    }

    @Test
    void shouldAcceptValidEmail() {
        Assertions.assertDoesNotThrow(() -> ValidationUtil.requireEmail("user@example.com"));
    }

    @Test
    void shouldEnforceMinimumLength() {
        Assertions.assertThrows(
                IllegalArgumentException.class,
                () -> ValidationUtil.requireMinLength("short", 8, "Password too short"));
    }
}
