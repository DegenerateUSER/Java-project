package com.ecommerce.rmi;

import java.math.BigDecimal;
import java.rmi.Remote;
import java.rmi.RemoteException;

public interface PaymentGateway extends Remote {
    boolean processPayment(Long userId, BigDecimal amount) throws RemoteException;
}
