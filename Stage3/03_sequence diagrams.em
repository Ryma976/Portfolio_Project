# 3. High-Level Sequence Diagrams

## Purpose

The sequence diagrams below show how the main components of Maksab (Frontend, Backend, Database, and external services) interact during the key MVP use cases. They follow the architecture, database design, and user stories defined in the previous sections.

**How to read the diagrams**
- Each vertical line is a component (or the user). Time flows from top to bottom.
- A solid arrow (`->>`) is a request or action. A dashed arrow (`-->>`) is a response.
- An `alt / else` block shows two possible outcomes (for example, success or failure).
- **Frontend** = React SPA, **Backend** = Flask REST API, **Database** = PostgreSQL.

## Use Cases Covered

| Diagram | Use case | User stories |
| :--- | :--- | :--- |
| 3.1 | Registration and login | US-01, US-02 |
| 3.2 | Product browsing and cart | US-08, US-10, US-11 |
| 3.3 | Checkout and payment | US-14, US-15 |
| 3.4 | Pricing calculator | US-12, US-13 |
| 3.5 | Supplier adds a product and views orders | US-04, US-06, US-07 |

---

## 3.1 User Registration and Login

```mermaid
sequenceDiagram
    actor User
    participant Frontend
    participant Backend
    participant Database

    User->>Frontend: Enter details and select role
    Frontend->>Backend: POST /api/auth/register
    Backend->>Database: Check if email already exists
    Database-->>Backend: Result

    alt Email is new
        Backend->>Backend: Hash password
        Backend->>Database: Create user account
        Database-->>Backend: Account created
        Backend-->>Frontend: 201 Registration successful
        Frontend-->>User: Show success and open login
    else Email already registered
        Backend-->>Frontend: 409 Email already registered
        Frontend-->>User: Show error message
    end

    User->>Frontend: Enter email and password
    Frontend->>Backend: POST /api/auth/login
    Backend->>Database: Find user by email
    Database-->>Backend: User record
    Backend->>Backend: Verify password against stored hash

    alt Valid credentials
        Backend-->>Frontend: 200 JWT token and role
        Frontend->>Frontend: Store token for later requests
        Frontend-->>User: Open Merchant or Supplier dashboard
    else Invalid credentials
        Backend-->>Frontend: 401 Invalid email or password
        Frontend-->>User: Show error message
    end
```

**Explanation**
- Registration checks that the email is not already used, then stores the password **hashed**, never as plain text.
- Login returns a **JWT token**. The Frontend attaches it to every later request so the Backend knows who the user is and what role they have.
- The error message does not reveal whether the email or the password was wrong.

---

## 3.2 Product Browsing and Cart

```mermaid
sequenceDiagram
    actor Merchant
    participant Frontend
    participant Backend
    participant Database

    Merchant->>Frontend: Search by name or filter by category and price
    Frontend->>Backend: GET /api/products with search and filters
    Backend->>Database: Query matching products
    Database-->>Backend: Matching products
    Backend-->>Frontend: Product list
    Frontend-->>Merchant: Display products

    Merchant->>Frontend: Open a product
    Frontend->>Backend: GET /api/products/:id
    Backend->>Database: Retrieve product details
    Database-->>Backend: Product details
    Backend-->>Frontend: Product information
    Frontend-->>Merchant: Display product page with MOQ

    Merchant->>Frontend: Add product with quantity
    Frontend->>Backend: POST /api/cart/items with JWT
    Backend->>Backend: Check quantity is at least MOQ and product is in stock

    alt Valid
        Backend->>Database: Save cart item
        Database-->>Backend: Cart updated
        Backend-->>Frontend: Cart grouped by Supplier with totals
        Frontend-->>Merchant: Display updated cart
    else Invalid
        Backend-->>Frontend: 400 Quantity below MOQ or out of stock
        Frontend-->>Merchant: Show error message
    end
```

**Explanation**
- Search and filtering run on the Backend and Database, so the Frontend only displays results.
- When adding to the cart, the Backend enforces the **Minimum Order Quantity** and stock status.
- The cart is returned **grouped by Supplier**, with a subtotal per Supplier and a grand total. A cart can hold products from several Suppliers.

---

## 3.3 Checkout and Payment

```mermaid
sequenceDiagram
    actor Merchant
    participant Frontend
    participant Backend
    participant Database
    participant Maps as Google Maps
    participant Moyasar

    Merchant->>Frontend: Pin delivery location on the map
    Frontend->>Maps: Load interactive map
    Maps-->>Frontend: Pin coordinates

    Merchant->>Frontend: Click Checkout
    Frontend->>Backend: POST /api/checkouts with location
    Backend->>Backend: Validate location is inside Riyadh
    Backend->>Database: Read cart items grouped by Supplier
    Database-->>Backend: Cart items
    Backend->>Database: Save checkout and one order per Supplier (pending payment)
    Database-->>Backend: Checkout created
    Backend-->>Frontend: Checkout ID and total

    Merchant->>Frontend: Enter card details
    Frontend->>Moyasar: Send card details directly
    Moyasar-->>Frontend: Payment token
    Frontend->>Backend: POST /api/checkouts/:id/payment with token
    Backend->>Moyasar: Create payment
    Moyasar-->>Backend: Payment created (pending)
    Backend->>Database: Save payment as pending
    Backend-->>Frontend: Redirect URL for bank verification
    Merchant->>Moyasar: Complete bank verification

    Moyasar-->>Backend: Webhook with payment ID
    Backend->>Moyasar: Fetch payment to verify status and amount

    alt Payment confirmed and amount matches
        Backend->>Database: Mark checkout, payment and all orders as paid
        Backend->>Database: Clear cart
        Frontend->>Backend: GET /api/checkouts/:id
        Backend-->>Frontend: Status paid
        Frontend-->>Merchant: Show order confirmation
    else Payment failed
        Backend->>Database: Mark payment as failed
        Frontend->>Backend: GET /api/checkouts/:id
        Backend-->>Frontend: Status failed
        Frontend-->>Merchant: Show error, cart is kept
    end
```

**Explanation**
- **Location:** the Merchant pins the delivery point on Google Maps. The Backend rejects locations outside Riyadh.
- **One checkout, many orders:** the cart is split into one **order per Supplier**, all under a single **checkout** with a single payment (pending until paid).
- **Card security:** card details go **directly to Moyasar** and never pass through our Backend. The Backend only receives a payment token.
- **Webhook and verification:** Moyasar notifies the Backend when the payment is done. The Backend does not trust that message alone. It **asks Moyasar directly** for the payment status and amount, and only then marks the checkout and all its orders as `paid`.
- **Failure:** if the payment fails, the cart is kept so the Merchant can try again.
- The MVP runs Moyasar in **sandbox (test) mode**.

---

## 3.4 Production Cost and Pricing Calculator

```mermaid
sequenceDiagram
    actor Merchant
    participant Frontend
    participant Backend

    Merchant->>Frontend: Open pricing calculator
    Frontend-->>Merchant: Display calculator form
    Merchant->>Frontend: Enter material, packaging, labor costs, quantity and margin
    Frontend->>Backend: POST /api/calculator/price

    alt Inputs valid
        Backend->>Backend: Calculate total cost and cost per unit
        Backend->>Backend: Calculate suggested price and profit per unit
        Backend-->>Frontend: Return results
        Frontend-->>Merchant: Display cost per unit, suggested price and profit
    else Invalid inputs
        Backend-->>Frontend: 400 Validation error
        Frontend-->>Merchant: Show error message
    end
```

**Explanation**
- The calculator is **standalone and stateless**: it uses no database, and nothing is saved.
- Inputs: material, packaging, and labor costs, the **number of units produced**, and the target margin.
- Formulas (margin is a percentage of the selling price):
  - `cost_per_unit = (material + packaging + labor) / quantity`
  - `suggested_price = cost_per_unit / (1 - margin / 100)`
  - `profit_per_unit = suggested_price - cost_per_unit`
- Invalid inputs (negative values, quantity of zero, margin of 100 or more) return an error.

---

## 3.5 Supplier: Add Product and Manage Orders

```mermaid
sequenceDiagram
    actor Supplier
    participant Frontend
    participant Backend
    participant Database

    Supplier->>Frontend: Fill product form (name, price, MOQ, category, photo)
    Frontend->>Backend: POST /api/products with JWT
    Backend->>Backend: Check role is Supplier and validate fields

    alt Valid
        Backend->>Database: Save product
        Database-->>Backend: Product saved
        Backend-->>Frontend: 201 Product created
        Frontend-->>Supplier: Show product in catalog
    else Invalid
        Backend-->>Frontend: 400 or 403 Error
        Frontend-->>Supplier: Show error message
    end

    Supplier->>Frontend: Open incoming orders
    Frontend->>Backend: GET /api/orders with JWT
    Backend->>Database: Get paid orders for this Supplier
    Database-->>Backend: Orders with items and delivery location
    Backend-->>Frontend: Orders list
    Frontend-->>Supplier: Display incoming orders

    Supplier->>Frontend: Update order status
    Frontend->>Backend: PUT /api/orders/:id/status
    Backend->>Backend: Check the order belongs to this Supplier
    Backend->>Database: Save new status
    Database-->>Backend: Status updated
    Backend-->>Frontend: Updated order
    Frontend-->>Supplier: Show new status
```

**Explanation**
- The Backend checks the **role** from the JWT, so only Suppliers can add products.
- A Supplier sees **only their own orders** (not other Suppliers' orders from the same checkout), and only after payment is confirmed.
- Order status update (Processing, Shipped, Delivered) is a Should Have story. The Backend verifies the order belongs to the requesting Supplier before saving.

---

## 3.6 Main Components

| Component | Responsibility |
| :--- | :--- |
| Merchant / Supplier | Interacts with the Maksab platform. |
| Frontend (React) | User interface; sends requests to the Backend and attaches the JWT. |
| Backend (Flask) | Business logic, authentication, products, carts, checkouts, orders, calculations, and payment verification. |
| Database (PostgreSQL) | Stores users, products, carts, checkouts, orders, and payments. |
| Moyasar | Processes online payments (sandbox in the MVP) and sends the payment webhook. |
| Google Maps | Interactive map for pinning the delivery location. |
