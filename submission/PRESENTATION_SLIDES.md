# Distributed E-Commerce Project
## Presentation Deck (Slide-by-Slide Content)

## Slide 1 - Title
- Advanced Java Mini Project
- Distributed E-Commerce Application
- Team: 6 Members
- Stack: Java 17, JSP/Servlet, Hibernate, PostgreSQL, RMI

## Slide 2 - Problem Statement
- Need a scalable enterprise-style e-commerce platform
- Must demonstrate multi-tier and distributed architecture
- Must support user, order, admin, and analytics workflows

## Slide 3 - Objectives
- Build modular web application using MVC approach
- Use ORM for persistence and clean DAO design
- Integrate distributed payment via Java RMI
- Deliver deployable WAR with documentation and demo

## Slide 4 - Technology Stack
- Java 17 + Maven
- JSP + Jakarta Servlets
- Hibernate ORM
- PostgreSQL
- Java RMI
- Tomcat 10
- JUnit 5 + SLF4J

## Slide 5 - Architecture
- Presentation Layer: JSP + Servlets
- Business Layer: Service classes
- Persistence Layer: DAO + Hibernate
- Distributed Layer: RMI payment server/client
- Database: PostgreSQL

## Slide 6 - Database Design
- users
- products
- cart
- orders
- order_items
- Entity relationships and ORM mapping summary

## Slide 7 - User Journey
- Register/Login
- Browse and search products
- Add to cart
- Place order
- Payment via RMI
- Order history + invoice

## Slide 8 - Admin Features
- Sales summary
- Top products
- Active users
- Manage user roles
- Manage product catalog (add/delete)

## Slide 9 - Security and Hardening
- Password hashing
- Session fixation mitigation
- Session timeout
- Input validation and error handling
- Stock integrity checks at checkout

## Slide 10 - Build and Verification
- `mvn clean verify`
- Tests run: 4, Failures: 0, Errors: 0
- BUILD SUCCESS
- WAR generated and deployment ready

## Slide 11 - Demo Plan
- Start app and login as user
- Add products to cart and place order
- Open invoice page
- Login as admin and show reports/management

## Slide 12 - Conclusion and Future Work
- Multi-tier distributed architecture achieved
- Core functional requirements completed
- Future: stronger password hashing, integration tests, CI/CD, product update workflow

## Slide 13 - Q&A
- Thank you
- Questions
