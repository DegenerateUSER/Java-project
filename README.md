# Distributed E-Commerce Application

Final implementation for the Advanced Java mini project using:

- JSP + Servlets (presentation layer)
- JavaBeans-style service classes (business layer)
- Hibernate ORM (persistence layer)
- Java RMI mock payment service (distributed layer)
- PostgreSQL database

## Prerequisites

- Java 17
- Maven 3.9+
- PostgreSQL
- Tomcat 10+

## Configure Database

1. Create DB and schema using `database.sql`.
2. Update DB credentials in `src/main/resources/hibernate.cfg.xml` or use environment variables:
	- `DB_URL`
	- `DB_USERNAME`
	- `DB_PASSWORD`

## Build

```bash
mvn clean package
```

WAR is generated in `target/distributed-ecommerce-1.0.0.war`.

## Verify

```bash
mvn clean verify
```

This runs tests and full build verification.

## Run

Deploy generated WAR to Tomcat.

Application URL:

- `http://localhost:8081/distributed-ecommerce-1.0.0/`

If `localhost:8080` is already used by another service (for example nginx), set Tomcat HTTP connector to port `8081` in Tomcat `server.xml`.

Default routes:

- `/register`
- `/login`
- `/products`
- `/cart`
- `/orders`
- `/invoice?orderId=<id>`
- `/admin` (requires user role `ADMIN`)

Default seeded admin:

- Email: `admin@ecommerce.local`
- Password: `Admin@123`

## Current scope implemented

- User registration and login
- Product listing and search
- Add to cart and checkout
- Order history
- Invoice generation
- RMI-based mock payment processing
- Admin reporting (sales summary, top products, active users)
- Admin user role management
- Admin product creation, deletion, and catalog monitoring
- Password hashing, session hardening, and validation improvements
- Automated test execution through Maven verify

## Submission Documents

- `docs/PHASE5_VERIFICATION.md`
- `submission/PROJECT_REPORT.md`
- `submission/PRESENTATION_SLIDES.md`
- `submission/PPT_COPY_READY_TEXT.md`
- `submission/DEMO_VIDEO_SCRIPT.md`
- `submission/DEMO_VIDEO_RECORDING_CHECKLIST.md`
- `submission/DELIVERABLES_CHECKLIST.md`
