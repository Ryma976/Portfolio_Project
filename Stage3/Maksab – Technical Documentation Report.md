# Maksab — Technical Documentation

## 1. Project Overview

**Maksab (مَكْسَب)** is a B2B wholesale marketplace and smart pricing calculator platform designed for home-based businesses and wholesale suppliers in Riyadh, Saudi Arabia.

The platform helps Merchants find wholesale raw materials and packaging supplies, compare products from Suppliers, manage wholesale orders, and calculate production costs and suggested selling prices.

The MVP focuses on the following core workflow:

```text
Business Need
      ↓
Find Required Materials
      ↓
Supplier Discovery
      ↓
Product Selection
      ↓
Cost Calculation
      ↓
Order & Payment
      ↓
Business Growth
```

### Target Users

* **Merchant:** A home-based business owner who purchases wholesale supplies and manages production costs.
* **Supplier:** A wholesale distributor who lists products and manages incoming orders.

The Admin Dashboard is outside the MVP scope and will be managed through backend and database administration.

---

# 2. User Stories and Scope Definition

## 2.1 MoSCoW Prioritization

The MVP user stories are prioritized using the MoSCoW method.

| Priority        | User Stories                                                     |
| --------------- | ---------------------------------------------------------------- |
| **Must Have**   | US-01, US-02, US-04, US-07, US-09, US-10, US-11, US-13, US-14    |
| **Should Have** | US-03, US-05, US-06, US-08, US-12, US-15                         |
| **Could Have**  | US-16                                                            |
| **Won't Have**  | Admin Dashboard, Saved Recipe Database, Live Driver GPS Tracking |

The complete user stories and scope definition are documented in the project's Task 0.

---

# 3. User Interface Mockups

The main MVP screens will be designed in **Figma**.

The planned screens include:

* Registration and Login
* Merchant Dashboard
* Supplier Dashboard
* Product Listing
* Product Details
* Shopping Cart
* Checkout
* Payment
* Order History
* Pricing Calculator
* Business Profile
* Location Selection

The mockups focus on the main user journeys and will be used as a reference during frontend implementation.

---

# 4. System Architecture

Maksab will follow a client-server architecture where the frontend communicates with the backend through a REST API.

```text
                    ┌─────────────────────┐
                    │       Users         │
                    │ Merchant / Supplier │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │      Frontend       │
                    │    Web Interface    │
                    └──────────┬──────────┘
                               │
                         REST API / JSON
                               │
                               ▼
                    ┌─────────────────────┐
                    │       Backend       │
                    │   Business Logic    │
                    │ Authentication      │
                    │ Products / Orders   │
                    │ Pricing Calculator  │
                    └──────┬───────┬──────┘
                           │       │
                  ┌────────┘       └──────────┐
                  ▼                           ▼
        ┌─────────────────┐          ┌─────────────────┐
        │    Database     │          │ External APIs   │
        │ Users           │          │ Google Maps     │
        │ Products        │          │ Moyasar         │
        │ Cart / Orders   │          └─────────────────┘
        └─────────────────┘
```

### Main Components

| Component   | Responsibility                 |
| ----------- | ------------------------------ |
| Frontend    | User interface and interaction |
| Backend     | Business logic and REST API    |
| Database    | Persistent application data    |
| Google Maps | Business and delivery location |
| Moyasar     | Online payment processing      |

---

# 5. Components and Database Design

## 5.1 Main Components

The backend will be divided logically into the following areas:

* Authentication
* User Profiles
* Product Management
* Product Search
* Shopping Cart
* Order Management
* Payment
* Pricing Calculator
* Location Management

## 5.2 Database Structure

The database will store the main entities required by the MVP.

```text
User
 ├── user_id
 ├── name
 ├── email
 ├── password
 └── role

Profile
 ├── profile_id
 ├── user_id
 ├── business_name
 ├── phone
 ├── address
 ├── latitude
 └── longitude

Product
 ├── product_id
 ├── supplier_id
 ├── name
 ├── description
 ├── category
 ├── price
 ├── MOQ
 └── stock_status

Cart
 ├── cart_id
 └── merchant_id

CartItem
 ├── cart_item_id
 ├── cart_id
 ├── product_id
 └── quantity

Order
 ├── order_id
 ├── merchant_id
 ├── total
 ├── status
 └── payment_status

OrderItem
 ├── order_item_id
 ├── order_id
 ├── product_id
 ├── quantity
 └── price
```

### Main Relationships

```text
User 1 ───── 1 Profile

User 1 ───── * Product
(Supplier)

User 1 ───── 1 Cart
(Merchant)

Cart 1 ───── * CartItem

Product 1 ───── * CartItem

User 1 ───── * Order
(Merchant)

Order 1 ───── * OrderItem

Product 1 ───── * OrderItem
```

---

# 6. Sequence Diagrams

The following diagrams describe the main MVP interactions:

### 6.1 User Registration and Login

Shows the interaction between the User, Frontend, Backend, and Database during registration and authentication.

### 6.2 Product Browsing, Cart, Checkout and Payment

Shows the main Merchant purchasing workflow, including product retrieval, cart management, order creation, and Moyasar payment processing.

### 6.3 Pricing Calculator

Shows how the Merchant provides production costs and profit margin and receives the calculated production cost, suggested selling price, and expected profit.

The detailed Mermaid sequence diagrams are provided in the project's Sequence Diagrams section.

---

# 7. API Specifications

## 7.1 External APIs

| API                 | Purpose                                                                  |
| ------------------- | ------------------------------------------------------------------------ |
| **Google Maps API** | Allows Merchants to select and provide their business/delivery location. |
| **Moyasar API**     | Handles online payment processing for wholesale orders.                  |

## 7.2 Internal REST API

The backend exposes RESTful endpoints using JSON.

| Endpoint                   | Method | Purpose                                     |
| -------------------------- | ------ | ------------------------------------------- |
| `/api/auth/register`       | POST   | Register a new user                         |
| `/api/auth/login`          | POST   | Authenticate a user                         |
| `/api/products`            | GET    | Search and retrieve products                |
| `/api/products/{id}`       | GET    | Retrieve product details                    |
| `/api/products`            | POST   | Create a product                            |
| `/api/products/{id}`       | PUT    | Update a product                            |
| `/api/cart`                | GET    | Retrieve current cart                       |
| `/api/cart/items`          | POST   | Add an item to cart                         |
| `/api/cart/items/{id}`     | PUT    | Update cart quantity                        |
| `/api/cart/items/{id}`     | DELETE | Remove cart item                            |
| `/api/orders`              | POST   | Create an order                             |
| `/api/orders`              | GET    | Retrieve order history                      |
| `/api/orders/{id}`         | GET    | Retrieve order details                      |
| `/api/orders/{id}/payment` | POST   | Process payment                             |
| `/api/calculator/price`    | POST   | Calculate production cost and selling price |
| `/api/profile`             | GET    | Retrieve user profile                       |
| `/api/profile`             | PUT    | Update user profile                         |
| `/api/profile/location`    | PUT    | Update business location                    |

All API requests and responses use JSON unless otherwise specified.

---

# 8. SCM and QA Plans

## 8.1 Software Configuration Management

The team will use **Git and GitHub** for version control.

### Branching Strategy

```text
main
  │
  └── development
       ├── feature/authentication
       ├── feature/products
       ├── feature/cart
       ├── feature/orders
       ├── feature/calculator
       └── feature/profile-location
```

### Development Process

1. Create a feature branch.
2. Implement the feature.
3. Commit changes regularly.
4. Push the feature branch to GitHub.
5. Create a Pull Request.
6. Perform code review.
7. Fix identified issues.
8. Merge into `development`.
9. Test the integrated feature.
10. Merge stable code into `main`.

Direct pushes to `main` should be avoided.

## 8.2 QA Strategy

Testing will be performed throughout development.

| Testing Type        | Tool / Method                       | Purpose                                 |
| ------------------- | ----------------------------------- | --------------------------------------- |
| Unit Testing        | Pytest                              | Test individual backend functions       |
| API Testing         | Postman                             | Test REST API endpoints                 |
| Integration Testing | Pytest / Postman                    | Verify backend and database interaction |
| End-to-End Testing  | Manual / automated where applicable | Verify complete user workflows          |
| Manual Testing      | Browser                             | Verify UI and critical user scenarios   |

### Critical Flows

The following flows will receive priority during QA:

* User registration and login
* Product search and viewing
* Adding products to the cart
* Order creation
* Payment
* Pricing calculation
* Location selection

---

# 9. Deployment Strategy

The project will use three stages:

```text
Feature Branch
      ↓
Development
      ↓
Staging
      ↓
QA Testing
      ↓
Main
      ↓
Production
```

### Development

Used for local development and initial feature testing.

### Staging

Used to test the integrated application before the final release.

### Production

Contains the stable version prepared for final deployment or project demonstration.

Before deployment, the team will verify that critical tests pass and that external API credentials and environment variables are securely configured.

---

# 10. Technical Justifications

## 10.1 REST API

A RESTful API was selected because it provides a simple and standard way for the frontend and backend to communicate.

Using JSON also makes it easy to exchange structured data between the application components.

## 10.2 Git and GitHub

Git provides version control and allows the team to work on separate features without affecting the stable codebase.

GitHub also provides Pull Requests and code reviews, which help identify issues before changes are merged.

## 10.3 Relational Database

A relational database is suitable for Maksab because the system contains structured relationships between users, products, carts, orders, and order items.

For example, an order can contain multiple products, while each product can appear in multiple orders.

## 10.4 Google Maps

Google Maps was selected because location is an important part of the Merchant checkout process. It allows users to select their location using an interactive map and provides coordinates that can be stored with the delivery information.

## 10.5 Moyasar

Moyasar was selected as the payment provider because Maksab targets businesses in Saudi Arabia and requires online payment functionality for wholesale orders.

## 10.6 Backend Architecture

Separating the frontend from the backend allows the business logic and database operations to remain independent from the user interface.

This also makes the system easier to maintain and allows the API to support future clients or applications.

## 10.7 Pricing Calculator

The pricing calculator is implemented as a separate backend service within the application rather than being tightly coupled with the marketplace.

This allows Merchants to calculate production costs and selling prices independently of whether they purchase a product through the marketplace.

---

# 11. MVP Scope Summary

The Maksab MVP focuses on the essential B2B marketplace workflow:

```text
Authentication
      ↓
Product Discovery
      ↓
Product Details
      ↓
Shopping Cart
      ↓
Location
      ↓
Checkout
      ↓
Payment
      ↓
Order Management
```

Alongside the marketplace, the standalone pricing calculator provides Merchants with a way to understand their production costs and determine appropriate selling prices.

Features such as the Admin Dashboard, saved recipe database, live driver tracking, and in-app messaging are excluded from the MVP or deferred according to the MoSCoW prioritization.

