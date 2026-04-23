# Demo Video Script
## Target Duration: 6-8 Minutes

## 0:00 - 0:30 Intro
Narration:
"This is our Advanced Java mini project: a distributed e-commerce system built with JSP/Servlets, Hibernate, PostgreSQL, and Java RMI."

Show:
- Project folder
- Architecture quick snapshot from report/presentation

## 0:30 - 1:15 Start Application
Narration:
"We run the application as a deployable WAR on Tomcat with PostgreSQL configured via Hibernate."

Show:
- Build command output (`mvn clean package`)
- App landing page

## 1:15 - 2:30 User Registration and Login
Narration:
"The user module supports registration, login, validation, and secure session management."

Show:
- Register new user
- Login flow
- Invalid login attempt example

## 2:30 - 3:45 Product and Cart
Narration:
"Users can browse products, search by keyword/category, and add stock-validated quantities to cart."

Show:
- Product search
- Add items to cart
- Cart total calculation

## 3:45 - 4:45 Checkout and Payment (RMI)
Narration:
"On checkout, the system invokes remote payment processing using Java RMI and stores order status."

Show:
- Place order action
- Order status in history

## 4:45 - 5:30 Invoice and Tracking
Narration:
"Each order provides an invoice view with printable details."

Show:
- Open invoice link
- Print preview button

## 5:30 - 7:00 Admin Dashboard
Narration:
"Admin module supports analytics and management operations."

Show:
- Admin login (`admin@ecommerce.local` / `Admin@123`)
- Sales summary
- Top products
- Active users
- Add product
- Delete product
- Change user role

## 7:00 - 7:30 Build Verification
Narration:
"Phase 5 verification is complete with successful Maven verify execution and zero test failures."

Show:
- `mvn clean verify` summary lines

## 7:30 - 8:00 Closing
Narration:
"The project demonstrates a complete multi-tier distributed enterprise design and is deployment-ready. Thank you."
