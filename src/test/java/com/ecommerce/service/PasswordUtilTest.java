package com.ecommerce.service;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class PasswordUtilTest {

    @Test
    void shouldHashAndMatchPassword() {
        String hash = PasswordUtil.hash("Secret@123");
        Assertions.assertNotNull(hash);
        Assertions.assertNotEquals("Secret@123", hash);
        Assertions.assertTrue(PasswordUtil.matches("Secret@123", hash));
        Assertions.assertFalse(PasswordUtil.matches("WrongPass", hash));
    }
}
