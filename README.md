# Distributed E-Commerce Application

Final implementation for the Advanced Java mini project using:

- JSP + Servlets (presentation layer)
- JavaBeans-style service classes (business layer)
- Hibernate ORM (persistence layer)
- Java RMI mock payment service (distributed layer)
- PostgreSQL database

## Prerequisites

- Java 17+ (project compiles with Java 17 target)
- Maven 3.9+
- PostgreSQL 14+
- Tomcat 10.1+ (Tomcat 11 also works)

## Configure Database

1. Create a PostgreSQL database named `ecommerce_db`.
2. Run the SQL statements from `database.sql` against `ecommerce_db`.
3. Configure credentials in one of these ways:

- Option A (edit file): update values in `src/main/resources/hibernate.cfg.xml`
- Option B (recommended): set environment variables before starting Tomcat

```bash
export DB_URL=jdbc:postgresql://localhost:5432/ecommerce_db
export DB_USERNAME=postgres
export DB_PASSWORD=postgres
```

Important: if you set env vars, start Tomcat from the same shell (or configure them in Tomcat startup env) so the app can read them.

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

1. Build the WAR:

```bash
mvn clean package
```

2. Deploy the generated WAR to Tomcat `webapps`:

```bash
cp target/distributed-ecommerce-1.0.0.war "$CATALINA_HOME/webapps/"
```

3. Start Tomcat:

```bash
"$CATALINA_HOME/bin/startup.sh"
```

If Tomcat is already running, restart it after redeploying.

Default context path (when deployed with original WAR name):

- `http://localhost:8080/distributed-ecommerce-1.0.0/`

If you deploy as `ROOT.war`, app URL becomes:

- `http://localhost:8080/`

If port `8080` is already occupied on your machine, change Tomcat HTTP connector port in `server.xml` and use that port in the URL.

Example alternate port:

- `http://localhost:8081/distributed-ecommerce-1.0.0/`

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

## Troubleshooting

- App URL returns 404 on `localhost:8080`:
	Another service may own port 8080. Check listeners and either stop the conflicting service or run Tomcat on another port (for example 8081).

- App fails during startup with RMI port error (`1099` in use):
	Free port 1099 or change the app RMI port in code/config.

- DB startup error like `role "postgres" does not exist`:
	Create the configured PostgreSQL role, or set `DB_USERNAME`/`DB_PASSWORD` to a valid existing role.

- DB connection mismatch between terminals and Tomcat:
	Ensure Tomcat process receives the same DB env vars you tested in terminal.

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
