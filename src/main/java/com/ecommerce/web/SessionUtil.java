package com.ecommerce.web;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public final class SessionUtil {

    private SessionUtil() {
    }

    public static Long getUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object raw = session.getAttribute("userId");
        if (raw instanceof Long id) {
            return id;
        }
        return null;
    }
}
