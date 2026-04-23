package com.ecommerce.rmi;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public final class RmiPaymentServer {

    private static final Logger LOGGER = LoggerFactory.getLogger(RmiPaymentServer.class);
    public static final int PORT = 1099;
    public static final String BINDING = "PaymentGateway";

    private static Registry registry;

    private RmiPaymentServer() {
    }

    public static synchronized void start() {
        if (registry != null) {
            return;
        }
        try {
            registry = LocateRegistry.createRegistry(PORT);
            registry.rebind(BINDING, new PaymentGatewayImpl());
            LOGGER.info("RMI payment server started on port {}", PORT);
        } catch (Exception ex) {
            throw new IllegalStateException("Failed to start RMI server", ex);
        }
    }
}
