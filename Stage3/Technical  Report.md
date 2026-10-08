# Stage 3 Report: Technical Documentation

**Portfolio Project – Holberton Saudi Arabia**
**Project:** Maksab (مَكْسَب) – B2B Wholesale Marketplace & Smart Pricing Calculator
**Team:** Reem Alanazi, Bayadir Aldossari, Shomukh Aldosari, Shahad Alharbi
**Document Version:** 1.0

---

## 1. User Stories and Prioritization (MoSCoW)

### Target Roles

* **Merchant:** Home-based business owner sourcing wholesale raw materials and packaging.
* **Supplier:** Wholesale distributor listing supplies and fulfilling bulk orders.

### MoSCoW Prioritization Matrix

| Priority        | ID    | Role     | User Story                                                                                 |
| --------------- | ----- | -------- | ------------------------------------------------------------------------------------------ |
| **Must Have**   | US-01 | Any      | As a new user, I want to register and select my role (Merchant or Supplier).               |
| **Must Have**   | US-02 | Any      | As a registered user, I want to log in and log out securely.                               |
| **Must Have**   | US-04 | Supplier | As a Supplier, I want to list wholesale products with price, description, MOQ, and images. |
| **Must Have**   | US-06 | Supplier | As a Supplier, I want to view incoming paid orders.                                        |
| **Must Have**   | US-08 | Merchant | As a Merchant, I want to search products by item or supplier name.                         |
| **Must Have**   | US-10 | Merchant | As a Merchant, I want to view product details and MOQ.                                     |
| **Must Have**   | US-11 | Merchant | As a Merchant, I want to manage my cart and view the dynamic total.                        |
| **Must Have**   | US-12 | Merchant | As a Merchant, I want to calculate my production cost per unit.                            |
| **Must Have**   | US-13 | Merchant | As a Merchant, I want to calculate my suggested selling price and profit.                  |
| **Must Have**   | US-14 | Merchant | As a Merchant, I want to select my business location using Google Maps.                    |
| **Must Have**   | US-15 | Merchant | As a Merchant, I want to pay for my order online through Moyasar.                          |
| **Must Have**   | US-16 | Merchant | As a Merchant, I want to view my order and transaction history.                            |
| **Should Have** | US-03 | Any      | Manage business profile and delivery information.                                          |
| **Should Have** | US-05 | Supplier | Update product price and stock status.                                                     |
| **Should Have** | US-07 | Supplier | Update order status.                                                                       |
| **Should Have** | US-09 | Merchant | Filter products by category and price range.                                               |
| **Should Have** | US-17 | Merchant | Download digital order receipts.                                                           |
| **Should Have** | US-18 | Merchant | Discover suppliers near the selected location.                                             |
| **Could Have**  | US-19 | Merchant | View estimated delivery cost based on distance.                                            |
| **Could Have**  | US-20 | Any      | Message suppliers about custom orders.                                                     |

---

## 2. System Architecture

Maksab follows a **three-tier architecture** consisting of a React frontend, Flask REST API backend, and PostgreSQL database.

```text
+-------------------------+
|     React Frontend      |
|      Maksab Web App     |
+------------+------------+
             |
             | REST API / JSON
             v
+-------------------------+
|     Python Flask        |
|   REST API & Business   |
|        Logic            |
+------+-------------+----+
       |             |
       v             v
+-------------+  +----------------------+
| PostgreSQL  |  | External APIs        |
|  Database   |  | Google Maps / Moyasar|
+-------------+  +----------------------+
```

### Key Architectural Choices

* **React.js:** Provides a dynamic Single Page Application.
* **Flask:** Handles REST APIs and business logic.
* **PostgreSQL:** Stores structured application data.
* **SQLAlchemy:** Handles database operations through ORM.
* **Nginx & SSL:** Provides secure reverse proxy and API forwarding.

---

## 3. Database Design

### Entity-Relationship Diagram

```text
USERS (1) ──── (N) PRODUCTS
  │                  │
  │                  │
  ├──── (1) CARTS    └──── (N) CART_ITEMS
  │                         │
  │                         │
  └──── (N) ORDERS ──── (N) ORDER_ITEMS
              │
              │
              └──── CHECKOUTS ──── PAYMENTS
```

### Database Schema

#### USERS

```text
id
name
email
password_hash
phone
role
business_name
address_text
latitude
longitude
created_at
```

#### CATEGORIES

```text
id
name
type
```

#### PRODUCTS

```text
id
supplier_id
category_id
name
description
price
unit
moq
stock_status
image_url
created_at
```

#### CARTS

```text
id
user_id
updated_at
```

#### CART_ITEMS

```text
id
cart_id
product_id
quantity
```

#### CHECKOUTS

```text
id
merchant_id
delivery_address
latitude
longitude
total
status
created_at
```

#### ORDERS

```text
id
checkout_id
merchant_id
supplier_id
total
status
created_at
```

#### ORDER_ITEMS

```text
id
order_id
product_id
quantity
unit_price
```

#### PAYMENTS

```text
id
checkout_id
method
amount
moyasar_payment_id
status
paid_at
```

---

## 4. Sequence Diagrams

### 4.1 Checkout and Payment Flow

```text
Merchant
   |
   v
React Frontend
   |
   | Create Checkout
   v
Flask API
   |
   +----> Google Maps
   |
   +----> PostgreSQL
   |
   | Payment Request
   v
Moyasar
   |
   | Payment Result
   v
Flask API
   |
   | Verify Payment
   v
PostgreSQL
   |
   | Order Confirmed
   v
Merchant
```

---

## 5. API Specifications

### Base URL

```text
/api
```

All API requests and responses use JSON. Authenticated endpoints require a JWT token.

### Pricing Calculator

**POST** `/api/calculator/price`

Request:

```json
{
  "material_cost": 20.00,
  "packaging_cost": 5.00,
  "labor_cost": 10.00,
  "quantity": 10,
  "profit_margin": 30
}
```

Response:

```json
{
  "total_production_cost": 35.00,
  "cost_per_unit": 3.50,
  "suggested_price_per_unit": 5.00,
  "expected_profit_per_unit": 1.50
}
```

### Create Checkout

**POST** `/api/checkouts`

Request:

```json
{
  "delivery_address": "Riyadh, Saudi Arabia",
  "latitude": 24.7136,
  "longitude": 46.6753
}
```

Response:

```json
{
  "message": "Checkout created successfully",
  "checkout": {
    "id": 55,
    "status": "pending_payment",
    "total": 12500.00
  }
}
```

### Payment Webhook

**POST** `/api/payments/webhook`

Used by Moyasar to notify the backend about payment status.

The backend verifies the payment before updating the checkout and order status.

### External APIs

| API             | Purpose                               |
| --------------- | ------------------------------------- |
| Google Maps API | Business location and map interaction |
| Moyasar API     | Online payment processing             |

---

## 6. SCM and QA Strategies

### Source Control Management

Git and GitHub are used for version control and team collaboration.

```text
main
  |
development
  |
feature/*
```

* Feature branches are used for individual tasks.
* Pull Requests are required before merging.
* Code reviews are performed by team members.
* GitHub Actions runs automated checks.

### Quality Assurance

Testing includes:

* **PyTest:** Backend unit and integration testing.
* **Jest / React Testing Library:** Frontend testing.
* **Postman:** API testing.
* **Flake8:** Python code quality.
* **ESLint / Prettier:** JavaScript code quality.
* **GitHub Actions:** Continuous Integration.

---

## 7. Technical Justifications

### React.js

Chosen because:

* Supports dynamic web interfaces.
* Suitable for Single Page Applications.
* Provides reusable components.

### Python Flask

Chosen because:

* Lightweight and flexible.
* Fast development cycle.
* Suitable for REST API development.
* Large community support.

### PostgreSQL

Chosen because:

* Reliable relational database.
* Supports structured relationships.
* Provides transactional consistency.

### SQLAlchemy

Chosen because:

* Simplifies database operations.
* Provides ORM support.
* Reduces repetitive SQL code.

### Moyasar

Chosen because:

* Supports online payments.
* Suitable for the Saudi market.
* Provides payment integration.

### Google Maps API

Chosen because:

* Provides location and map services.
* Allows merchants to select their business location.

### Modular Architecture

Chosen because:

* Easier maintenance.
* Clear separation of responsibilities.
* Supports future expansion.

---

# Final Technical Documentation Summary

This Technical Documentation includes:

* User Stories and Prioritization
* System Architecture
* Database Design
* Sequence Diagrams
* API Specifications
* SCM and QA Strategies
* Technical Justifications

### Team

**Reem Alanazi**
**Bayadir Aldossari**
**Shomukh Aldosari**
**Shahad Alharbi**

### Document Version

**1.0**
