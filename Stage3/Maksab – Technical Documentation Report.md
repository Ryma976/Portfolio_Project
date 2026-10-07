# Maksab – Technical Documentation Report

## 1. Introduction

Maksab is a B2B platform designed to support home-based businesses and productive families by connecting them with wholesale suppliers. The platform helps merchants find materials and packaging, compare products, calculate production costs, and make better pricing decisions.

The system focuses on simplifying the purchasing process while providing tools that help small businesses manage their costs and improve their profitability.

---

## 2. User Stories and Mockups

The system requirements were defined using User Stories and prioritized using the MoSCoW method.

### Must Have

* User registration and login.
* Supplier product listing.
* Product search and product details.
* Shopping cart management.
* Production cost calculator.
* Business location selection.
* Online payment.

### Should Have

* Business profile management.
* Supplier product and stock updates.
* Supplier order management.
* Product filtering.
* Selling price and profit calculation.
* Order history and digital receipts.

### Could Have

* In-app communication between merchants and suppliers.

### Won't Have

* Admin dashboard.
* Saved recipe database.
* Live driver GPS tracking.

The main user interfaces were designed as Figma mockups. The mockups cover the main merchant and supplier flows, including authentication, product browsing, cart, checkout, and pricing calculation.

---

## 3. System Architecture

Maksab follows a client-server architecture where the frontend communicates with the backend through REST APIs.

### High-Level Architecture

```text
+----------------------+
|       Users          |
| Merchant / Supplier  |
+----------+-----------+
           |
           v
+----------------------+
|      Frontend        |
|      Web Interface   |
+----------+-----------+
           |
        REST API
           |
           v
+----------------------+
|       Backend        |
| Business Logic & API |
+----+------------+----+
     |            |
     v            v
+---------+   +----------------+
|Database |   | External APIs  |
|         |   | Google Maps    |
|         |   | Moyasar        |
+---------+   +----------------+
```

The frontend is responsible for the user interface, while the backend handles authentication, business logic, product management, orders, cart operations, and the pricing calculator. The database stores users, products, carts, orders, and related information.

Google Maps is used for location selection, while Moyasar is used for online payment processing.

---

## 4. Components and Database Design

### Main Components

The system is divided into several main components:

* **Authentication:** Registration and login.
* **User Profile:** Business information and location.
* **Product Management:** Product listing, pricing, stock, and product details.
* **Marketplace:** Searching, filtering, and browsing products.
* **Cart:** Adding, removing, and updating product quantities.
* **Orders:** Creating and tracking wholesale orders.
* **Pricing Calculator:** Calculating production cost, selling price, and expected profit.
* **Payment:** Processing online payments through Moyasar.

### Database Design

A relational database is used to maintain structured relationships between users, products, carts, and orders.

Main entities include:

| Entity    | Purpose                                    |
| --------- | ------------------------------------------ |
| User      | Stores authentication and role information |
| Profile   | Stores business and contact information    |
| Product   | Stores supplier product information        |
| Cart      | Stores a merchant's active cart            |
| CartItem  | Stores products and quantities in the cart |
| Order     | Stores wholesale order information         |
| OrderItem | Stores products included in an order       |

### Main Relationships

```text
User 1 ─── 1 Profile
User 1 ─── N Products
User 1 ─── 1 Cart
Cart 1 ─── N CartItems
Product 1 ─── N CartItems
User 1 ─── N Orders
Order 1 ─── N OrderItems
Product 1 ─── N OrderItems
```

The database design supports the main marketplace workflow while keeping the data organized and consistent.

---

## 5. Sequence Diagrams

Three key interactions were selected because they represent important parts of the system.

### 5.1 Registration and Login

```text
User
  |
  | Register/Login
  v
Frontend
  |
  | API Request
  v
Backend
  |
  | Validate User
  v
Database
  |
  | User Data
  v
Backend
  |
  | Response
  v
Frontend
  |
  v
User
```

### 5.2 Product Browsing, Cart and Checkout

```text
Merchant
   |
   v
Frontend
   |
   | Request Products
   v
Backend
   |
   v
Database
   |
   | Products
   v
Frontend
   |
   | Add to Cart
   v
Backend
   |
   v
Cart / Database
   |
   | Checkout
   v
Moyasar
   |
   | Payment Result
   v
Backend
   |
   v
Order Created
```

### 5.3 Pricing Calculator

```text
Merchant
   |
   | Enter Material, Packaging,
   | Labor and Profit Margin
   v
Frontend
   |
   | Calculator Request
   v
Backend
   |
   | Calculate Cost & Price
   v
Backend
   |
   | Result
   v
Frontend
   |
   v
Merchant
```

These diagrams describe how the main system components communicate during the selected use cases.

---

## 6. API Specifications

### External APIs

| API             | Purpose                                                     |
| --------------- | ----------------------------------------------------------- |
| Google Maps API | Allows merchants to select and save their business location |
| Moyasar API     | Handles secure online payment processing                    |

### Internal API

The backend provides REST API endpoints under the `/api` path.

| Method | Endpoint                   | Purpose                                     |
| ------ | -------------------------- | ------------------------------------------- |
| POST   | `/api/auth/register`       | Register a new user                         |
| POST   | `/api/auth/login`          | Authenticate a user                         |
| GET    | `/api/products`            | Retrieve products                           |
| GET    | `/api/products/{id}`       | Retrieve product details                    |
| POST   | `/api/products`            | Add a product                               |
| PUT    | `/api/products/{id}`       | Update a product                            |
| GET    | `/api/cart`                | Retrieve the current cart                   |
| POST   | `/api/cart/items`          | Add an item to the cart                     |
| PUT    | `/api/cart/items/{id}`     | Update item quantity                        |
| DELETE | `/api/cart/items/{id}`     | Remove an item                              |
| POST   | `/api/orders`              | Create an order                             |
| GET    | `/api/orders`              | Retrieve order history                      |
| GET    | `/api/orders/{id}`         | Retrieve order details                      |
| POST   | `/api/orders/{id}/payment` | Process order payment                       |
| POST   | `/api/calculator/price`    | Calculate production cost and selling price |
| GET    | `/api/profile`             | Retrieve business profile                   |
| PUT    | `/api/profile`             | Update business profile                     |
| PUT    | `/api/profile/location`    | Update business location                    |

Requests that require data use JSON request bodies, while responses are returned in JSON format.

---

## 7. SCM and QA Strategy

### Source Code Management

Git and GitHub are used to manage the source code and collaborate between team members.

The main branches are:

* `main` – stable version.
* `development` – active development and integration.
* `feature/*` – individual features.

Team members work on feature branches and create Pull Requests before merging changes into the development branch. Code reviews are used to identify issues and maintain code quality.

Commits should be clear and related to a specific change, for example:

```text
feat: add product search
fix: update cart quantity
test: add calculator tests
docs: update API documentation
```

### Quality Assurance

Testing focuses on the main functionality of the system:

* Authentication.
* Product browsing and search.
* Cart operations.
* Order creation.
* Payment flow.
* Pricing calculations.
* Profile and location management.

The testing process includes:

1. Unit testing for individual functions.
2. API testing using Postman.
3. Integration testing between system components.
4. End-to-end testing for important user flows.
5. Manual testing before release.

A feature is considered complete after implementation, testing, code review, and successful integration.

---

## 8. Technical Justifications

### REST API

REST was selected because it provides a simple and structured way for the frontend and backend to communicate. It also makes the system easier to maintain and extend.

### Relational Database

A relational database is suitable because Maksab contains structured data with clear relationships between users, products, carts, and orders.

### Backend Framework

A backend framework provides routing, request handling, validation, and business logic in an organized structure. This reduces duplicated code and makes the application easier to maintain.

### Google Maps

Google Maps was selected to provide an interactive and familiar way for merchants to select their business location accurately.

### Moyasar

Moyasar was selected to support online payments and provide a payment service suitable for the Saudi market.

### Separate Frontend and Backend

Separating the frontend from the backend keeps the user interface and business logic independent. This makes development easier for multiple team members and allows each part of the system to be developed and tested separately.

---

## 9. Conclusion

The technical design of Maksab is based on a modular client-server architecture with a REST API, relational database, external location and payment services, and a structured development and testing process.

The design covers the main requirements of the platform and provides a foundation that can be extended with additional features in the future.
