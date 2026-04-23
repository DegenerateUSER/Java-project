# Distributed E-Commerce Application
## Final Project Report

## 1. Project Overview

This project implements a multi-tier distributed e-commerce application using Java technologies:

- Presentation Layer: JSP + Servlets
- Business Layer: JavaBeans-style service classes
- Persistence Layer: Hibernate ORM with PostgreSQL
- Distributed Layer: Java RMI for remote payment processing (mock)

The application allows customers to register, log in, browse products, manage cart items, place orders, complete payment through a remote service, and access order history/invoices. Administrators can manage users and products and view analytics.

## 2. Objectives

1. Demonstrate enterprise-style layered architecture.
2. Implement distributed service communication using Java RMI.
3. Apply ORM-based persistence with Hibernate and PostgreSQL.
4. Build secure and maintainable web workflows.
5. Deliver a deployable artifact and complete submission documentation.

## 3. Technology Stack

- Java 17
- Maven (WAR packaging)
- Jakarta Servlet API 6.0
- JSP
- Hibernate ORM 6.x
- PostgreSQL
- Java RMI
- SLF4J logging
- JUnit 5 for test execution
- Apache Tomcat 10+

## 4. Architecture

## 4.1 Layered Structure

1. Presentation Layer
- JSP pages for UI rendering
- Servlets for request handling, validation, and navigation

2. Business Layer
- Service classes encapsulating business rules:
  - `AuthService`
  - `ProductService`
  - `CartService`
  - `OrderService`
  - `AdminService`

3. Persistence Layer
- DAO classes for database operations:
  - `UserDao`
  - `ProductDao`
  - `CartDao`
  - `OrderDao`

4. Distributed Layer
- RMI interfaces and server/client for payment validation:
  - `PaymentGateway`
  - `PaymentGatewayImpl`
  - `RmiPaymentServer`
  - `RmiPaymentClient`

## 4.2 Request Flow

User request -> Servlet -> Service -> DAO/Hibernate -> PostgreSQL

For checkout:
Servlet -> `OrderService` -> `RmiPaymentClient` -> RMI payment server -> Order status update -> DB write

## 5. Module Implementation

## 5.1 User Module

- Registration with validation and duplicate email prevention
- Login with hashed password verification
- Session-based authentication
- Logout and session invalidation

## 5.2 Product Module

- Product listing
- Product search by name/category
- Category-aware display
- Stock-aware cart add constraints

## 5.3 Cart Module

- Add product to cart
- Cart summary with line totals and grand total
- Validation for quantity and stock

## 5.4 Order Management Module

- Place order from cart
- Payment processing via RMI (mock)
- Order history
- Invoice generation and print view

## 5.5 Payment Module (Distributed)

- Remote payment method exposed via RMI
- Mock validation result (success when amount > 0)
- Order marked `PAID` or `FAILED` based on remote response

## 5.6 Admin Module

- Sales summary analytics
- Top products analytics
- Active user count
- User role management (`USER`, `ADMIN`)
- Product management (add and delete)

## 6. Database Design

Tables implemented:

1. `users`
- `user_id`
- `name`
- `email`
- `password`
- `role`

2. `products`
- `product_id`
- `name`
- `price`
- `stock`
- `category`

3. `cart`
- `cart_id`
- `user_id`
- `product_id`
- `quantity`

4. `orders`
- `order_id`
- `user_id`
- `date`
- `status`

5. `order_items`
- `order_item_id`
- `order_id`
- `product_id`
- `quantity`
- `price`

## 7. Security and Reliability Measures

1. Password hashing before persistence
2. Session fixation mitigation
3. Session timeout control
4. Input validation and user-facing error messages
5. Stock validation for cart and order operations
6. Runtime error mapping to unified error page
7. Environment-driven DB configuration support

## 8. Testing and Verification

Build and verification command:

```bash
mvn clean verify
```

Results:
- BUILD SUCCESS
- Tests run: 4
- Failures: 0
- Errors: 0
- Skipped: 0

Additional validation:
- Deployable WAR generated at `target/distributed-ecommerce-1.0.0.war`
- Functional flows verified for user journey and admin dashboard

## 9. Deployment Instructions

1. Create PostgreSQL database and schema using `database.sql`.
2. Configure DB credentials in `hibernate.cfg.xml` or via environment variables:
- `DB_URL`
- `DB_USERNAME`
- `DB_PASSWORD`
3. Build WAR:

```bash
mvn clean package
```

4. Deploy WAR to Tomcat 10+.
5. Access routes:
- `/register`
- `/login`
- `/products`
- `/cart`
- `/orders`
- `/invoice?orderId=...`
- `/admin`

Default seeded admin:
- Email: `admin@ecommerce.local`
- Password: `Admin@123`

## 10. Requirement Traceability Matrix

1. User Registration/Login -> Implemented
2. Product listing/search/category -> Implemented
3. Cart and place order -> Implemented
4. Payment module via RMI -> Implemented
5. Order history/tracking/invoice -> Implemented
6. Admin users/products/reports -> Implemented
7. Session management -> Implemented
8. Form validation -> Implemented
9. Exception handling/logging baseline -> Implemented
10. Enterprise deployable package -> Implemented (WAR)

## 11. Limitations and Future Enhancements

1. Replace basic hash strategy with salted adaptive password hashing.
2. Add servlet integration tests and UI automation tests.
3. Add product update flow in admin.
4. Add pagination and caching for large catalogs.
5. Add containerized deployment and CI/CD pipeline.

## 12. Conclusion

The project successfully delivers a distributed multi-tier e-commerce system with a clear enterprise architecture and functional module coverage aligned with the project statement. It is build-verified, deployable, and includes documentation-ready deliverables for submission.
