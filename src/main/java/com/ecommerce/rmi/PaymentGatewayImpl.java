package com.ecommerce.rmi;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class PaymentGatewayImpl extends UnicastRemoteObject implements PaymentGateway {

    private static final Logger LOGGER = LoggerFactory.getLogger(PaymentGatewayImpl.class);

    public PaymentGatewayImpl() throws RemoteException {
        super();
    }

    @Override
    public boolean processPayment(Long userId, BigDecimal amount) {
        LOGGER.info("RMI payment invoked for user {} amount {}", userId, amount);
        return amount != null && amount.signum() > 0;
    }
}
