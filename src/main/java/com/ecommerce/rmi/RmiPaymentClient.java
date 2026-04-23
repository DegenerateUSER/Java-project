package com.ecommerce.rmi;

import java.math.BigDecimal;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class RmiPaymentClient {

    public boolean processPayment(Long userId, BigDecimal amount) {
        try {
            Registry registry = LocateRegistry.getRegistry("localhost", RmiPaymentServer.PORT);
            PaymentGateway gateway = (PaymentGateway) registry.lookup(RmiPaymentServer.BINDING);
            return gateway.processPayment(userId, amount);
        } catch (Exception ex) {
            return false;
        }
    }
}
