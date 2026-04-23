package com.ecommerce.dao;

import com.ecommerce.config.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.function.Function;

public abstract class BaseDao {

    protected <T> T executeInTransaction(Function<Session, T> callback) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            T result = callback.apply(session);
            tx.commit();
            return result;
        } catch (RuntimeException ex) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (RuntimeException rollbackEx) {
                    ex.addSuppressed(rollbackEx);
                }
            }
            throw ex;
        }
    }
}
