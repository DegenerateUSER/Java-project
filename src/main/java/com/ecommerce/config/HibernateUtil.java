package com.ecommerce.config;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

public final class HibernateUtil {

    private static final SessionFactory SESSION_FACTORY = buildSessionFactory();

    private HibernateUtil() {
    }

    private static SessionFactory buildSessionFactory() {
        Configuration configuration = new Configuration().configure("hibernate.cfg.xml");

        overrideIfPresent(configuration, "DB_URL", "hibernate.connection.url");
        overrideIfPresent(configuration, "DB_USERNAME", "hibernate.connection.username");
        overrideIfPresent(configuration, "DB_PASSWORD", "hibernate.connection.password");

        ServiceRegistry serviceRegistry =
                new StandardServiceRegistryBuilder().applySettings(configuration.getProperties()).build();
        return configuration.buildSessionFactory(serviceRegistry);
    }

    private static void overrideIfPresent(Configuration configuration, String envName, String hibernateProperty) {
        String value = System.getenv(envName);
        if (value != null && !value.isBlank()) {
            configuration.setProperty(hibernateProperty, value);
        }
    }

    public static SessionFactory getSessionFactory() {
        return SESSION_FACTORY;
    }
}
