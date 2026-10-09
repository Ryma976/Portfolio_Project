# 4. External and Internal APIs

## 4.1 External APIs

Maksab integrates two external services. Both are accessed according to the architecture: Google Maps is loaded by the Frontend, and Moyasar is called by the Backend (card details go from the Frontend directly to Moyasar).

| External API | How Maksab uses it | Why it was chosen |
| :--- | :--- | :--- |
| **Google Maps Platform** | **Maps JavaScript API** (Frontend): interactive map where the Merchant drops and moves a pin for the delivery location (US-14). **Distance Matrix API** (Backend, optional): distance between Merchant and Supplier for nearby-supplier sorting and delivery cost (US-18, US-19). | Reliable maps with strong coverage of Riyadh, an interactive draggable pin, and a well-documented JavaScript API. |
| **Moyasar API** | **Payments API**: create a payment for a checkout and fetch a payment to verify its status and amount. **Tokens**: card details are exchanged for a token directly from the Frontend. **Webhooks**: Moyasar notifies the Backend when a payment status changes. | A Saudi payment gateway that supports mada and credit cards, provides a sandbox for testing, and keeps card data off our servers. |

**Keys and modes**
- Moyasar runs in **sandbox (test) mode** in the MVP.
- The Moyasar **secret key** stays on the Backend only. The Frontend uses only the Moyasar publishable key.
- The Google Maps key is used in the browser, so it is restricted to the project's domain (HTTP referrer restriction).
- The Riyadh boundary check (US-14) is done in the Backend with a coordinate boundary, so it needs no external API.

---

## 4.2 Internal REST API: Conventions

- **Base URL:** `/api`
- **Format:** JSON for all requests and responses (`Content-Type: application/json`).
- **Authentication:** protected endpoints require the header `Authorization: Bearer <JWT>`, obtained from login. The token carries the user's ID and role.
- **Authorization:** the Backend checks the role (Merchant or Supplier) and ownership (for example, a Supplier can edit only their own products and orders).
- **Errors** use a consistent format:

```json
{ "error": "Quantity is below the minimum order quantity" }
```

| Status | Meaning |
| :--- | :--- |
| 200 | Success |
| 201 | Resource created |
| 400 | Invalid input (validation error) |
| 401 | Missing or invalid token, or wrong credentials |
| 403 | Authenticated but not allowed (wrong role or not the owner) |
| 404 | Resource not found |
| 409 | Conflict (for example, email already registered) |

## 4.3 Endpoint Summary

| Method | Path | Access | Purpose | Story |
| :--- | :--- | :--- | :--- | :--- |
| POST | `/api/auth/register` | Public | Register and select role | US-01 |
| POST | `/api/auth/login` | Public | Login, returns JWT | US-02 |
| GET | `/api/profile` | Any user | View profile | US-03 |
| PUT | `/api/profile` | Any user | Update profile | US-03 |
| PUT | `/api/profile/location` | Any user | Save default business location | US-14 |
| GET | `/api/categories` | Any user | List categories (for filters and product form) | US-04, 09 |
| GET | `/api/products` | Any user | Search and filter products | US-08, 09 |
| GET | `/api/products/{id}` | Any user | Product details | US-10 |
| POST | `/api/products` | Supplier | Create product | US-04 |
| PUT | `/api/products/{id}` | Supplier (owner) | Update price or stock | US-05 |
| GET | `/api/cart` | Merchant | View cart grouped by Supplier | US-11 |
| POST | `/api/cart/items` | Merchant | Add item | US-11 |
| PUT | `/api/cart/items/{id}` | Merchant | Change quantity | US-11 |
| DELETE | `/api/cart/items/{id}` | Merchant | Remove item | US-11 |
| POST | `/api/checkouts` | Merchant | Create checkout and one order per Supplier | US-14, 15 |
| GET | `/api/checkouts/{id}` | Merchant | Checkout and payment status | US-15 |
| POST | `/api/checkouts/{id}/payment` | Merchant | Start the single Moyasar payment | US-15 |
| GET | `/api/checkouts/{id}/receipt` | Merchant | Receipt for a paid checkout | US-17 |
| POST | `/api/payments/webhook` | Moyasar | Payment status notification | US-15 |
| GET | `/api/orders` | Merchant / Supplier | Order history (Merchant) or incoming orders (Supplier) | US-06, 16 |
| GET | `/api/orders/{id}` | Merchant / Supplier | Order details | US-06, 16 |
| PUT | `/api/orders/{id}/status` | Supplier (owner) | Update order status | US-07 |
| POST | `/api/calculator/price` | Merchant | Cost and suggested price | US-12, 13 |

---

## 4.4 Authentication Endpoints

### Register: `POST /api/auth/register`

Request:

```json
{
  "name": "Ahmed Ali",
  "email": "ahmed@example.com",
  "password": "********",
  "role": "merchant",
  "business_name": "Ahmed Home Kitchen"
}
```

Response `201`:

```json
{
  "message": "User registered successfully",
  "user": { "id": 1, "name": "Ahmed Ali", "email": "ahmed@example.com", "role": "merchant" }
}
```

Errors: `400` missing or invalid fields, `409` email already registered.

### Login: `POST /api/auth/login`

Request:

```json
{ "email": "ahmed@example.com", "password": "********" }
```

Response `200`:

```json
{
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "user": { "id": 1, "name": "Ahmed Ali", "role": "merchant" }
}
```

Error: `401` invalid email or password.

**Logout** is handled in the Frontend by deleting the stored token (JWT is stateless).

---

## 4.5 Profile and Location Endpoints

### `GET /api/profile`

Response `200`:

```json
{
  "id": 1,
  "name": "Ahmed Ali",
  "email": "ahmed@example.com",
  "role": "merchant",
  "business_name": "Ahmed Home Kitchen",
  "phone": "0500000000",
  "address_text": "Riyadh, Saudi Arabia",
  "latitude": 24.7136,
  "longitude": 46.6753
}
```

### `PUT /api/profile`

Request (any subset of fields):

```json
{ "business_name": "Ahmed Home Kitchen", "phone": "0500000000", "address_text": "Al Olaya, Riyadh" }
```

Response `200`: the updated profile.

### `PUT /api/profile/location`

Saves the Merchant's default location. The location chosen during checkout is saved on the checkout itself.

Request:

```json
{ "latitude": 24.7136, "longitude": 46.6753, "address": "Riyadh, Saudi Arabia" }
```

Response `200`:

```json
{
  "message": "Location updated successfully",
  "location": { "latitude": 24.7136, "longitude": 46.6753, "address": "Riyadh, Saudi Arabia" }
}
```

Error: `400` if the coordinates are outside Riyadh.

---

## 4.6 Category and Product Endpoints

### `GET /api/categories`

Response `200`:

```json
{
  "categories": [
    { "id": 1, "name": "Flour and Grains", "type": "raw_material" },
    { "id": 2, "name": "Food Boxes", "type": "packaging" }
  ]
}
```

### `GET /api/products`

Query parameters (all optional):

| Parameter | Description |
| :--- | :--- |
| `search` | Matches product name or Supplier name |
| `category` | `raw_material` or `packaging` |
| `min_price`, `max_price` | Price range |
| `page`, `limit` | Pagination |

Example: `GET /api/products?search=box&category=packaging&max_price=100`

Response `200`:

```json
{
  "products": [
    {
      "id": 12,
      "name": "Paper Food Boxes",
      "category": "packaging",
      "price": 45.00,
      "unit": "box",
      "moq": 100,
      "stock_status": "in_stock",
      "image_url": "https://example.com/boxes.jpg",
      "supplier_id": 5,
      "supplier_name": "Al-Noor Packaging"
    }
  ],
  "page": 1,
  "total": 1
}
```

### `GET /api/products/{id}`

Response `200`:

```json
{
  "id": 12,
  "name": "Paper Food Boxes",
  "description": "Food-safe paper boxes",
  "category": "packaging",
  "price": 45.00,
  "unit": "box",
  "moq": 100,
  "stock_status": "in_stock",
  "image_url": "https://example.com/boxes.jpg",
  "supplier_id": 5,
  "supplier_name": "Al-Noor Packaging"
}
```

Error: `404` product not found.

### `POST /api/products` (Supplier)

Request:

```json
{
  "name": "Paper Food Boxes",
  "description": "Food-safe paper boxes",
  "category_id": 2,
  "price": 45.00,
  "unit": "box",
  "moq": 100,
  "stock_status": "in_stock",
  "image_url": "https://example.com/boxes.jpg"
}
```

Response `201`: the created product (same shape as product details).
Errors: `400` invalid price or MOQ, `403` user is not a Supplier.

### `PUT /api/products/{id}` (Supplier, owner)

Request (any subset of fields):

```json
{ "price": 48.00, "stock_status": "out_of_stock" }
```

Response `200`: the updated product. Error: `403` if the product belongs to another Supplier.

---

## 4.7 Cart Endpoints (Merchant)

The cart can hold products from several Suppliers and is always returned **grouped by Supplier**.

### `GET /api/cart`

Response `200`:

```json
{
  "groups": [
    {
      "supplier_id": 5,
      "supplier_name": "Al-Noor Packaging",
      "items": [
        { "item_id": 7, "product_id": 12, "name": "Paper Food Boxes", "quantity": 200, "unit_price": 45.00, "subtotal": 9000.00 }
      ],
      "subtotal": 9000.00
    }
  ],
  "total": 9000.00
}
```

### `POST /api/cart/items`

Request:

```json
{ "product_id": 12, "quantity": 200 }
```

Response `201`: `{ "message": "Item added to cart", "cart": { ...same shape as GET /api/cart... } }`

Errors: `400` quantity below MOQ or product out of stock, `404` product not found.

### `PUT /api/cart/items/{id}`

Request: `{ "quantity": 300 }`
Response `200`: the updated cart. Error: `400` quantity below MOQ.

### `DELETE /api/cart/items/{id}`

Response `200`: the updated cart.

---

## 4.8 Checkout, Payment, and Order Endpoints

One **checkout** equals one payment. It splits into **one order per Supplier**.

### `POST /api/checkouts` (Merchant)

Creates the checkout and its orders from the current cart.

Request:

```json
{ "delivery_address": "Riyadh, Saudi Arabia", "latitude": 24.7136, "longitude": 46.6753 }
```

Response `201`:

```json
{
  "message": "Checkout created successfully",
  "checkout": {
    "id": 55,
    "status": "pending_payment",
    "total": 12500.00,
    "orders": [
      { "id": 101, "supplier_id": 5, "total": 9000.00, "status": "pending_payment" },
      { "id": 102, "supplier_id": 8, "total": 3500.00, "status": "pending_payment" }
    ]
  }
}
```

Errors: `400` empty cart or location outside Riyadh.

### `POST /api/checkouts/{id}/payment` (Merchant)

Starts the single payment for the whole checkout. The Frontend first sends the card details directly to Moyasar and receives a token.

Request:

```json
{ "payment_method": "card", "token": "token_abc123" }
```

Response `200`:

```json
{
  "message": "Payment started",
  "checkout_id": 55,
  "payment_status": "pending",
  "redirect_url": "https://example-moyasar-verification-url"
}
```

The Merchant completes the bank verification at `redirect_url`. The payment is **not** marked paid here. The final status comes from the webhook and server-side verification below.

### `POST /api/payments/webhook` (called by Moyasar)

Moyasar sends the payment ID and event when a payment changes status. The Backend:
1. Checks the request is genuine (shared secret configured with Moyasar).
2. Fetches the payment from the Moyasar API and compares the **status** and **amount** with the checkout.
3. If confirmed, marks the payment, the checkout, and all its orders as `paid`, and clears the cart. Otherwise marks the payment `failed`.

Response `200` (empty body) so Moyasar does not retry.

### `GET /api/checkouts/{id}` (Merchant)

The Frontend uses this to show the result after payment.

Response `200`:

```json
{
  "id": 55,
  "status": "paid",
  "total": 12500.00,
  "delivery_address": "Riyadh, Saudi Arabia",
  "orders": [
    { "id": 101, "supplier_id": 5, "total": 9000.00, "status": "paid" },
    { "id": 102, "supplier_id": 8, "total": 3500.00, "status": "paid" }
  ]
}
```

### `GET /api/checkouts/{id}/receipt` (Merchant, Should Have)

Response `200`:

```json
{
  "checkout_id": 55,
  "paid_at": "2026-10-08T10:30:00Z",
  "method": "card",
  "total": 12500.00,
  "orders": [
    { "supplier_name": "Al-Noor Packaging", "items": [ { "name": "Paper Food Boxes", "quantity": 200, "unit_price": 45.00 } ], "subtotal": 9000.00 }
  ]
}
```

Error: `400` if the checkout is not paid.

### `GET /api/orders`

- **Merchant:** their own orders (order history, US-16).
- **Supplier:** only their own **paid** orders (incoming orders, US-06).

Response `200`:

```json
{
  "orders": [
    {
      "id": 101,
      "checkout_id": 55,
      "supplier_id": 5,
      "status": "paid",
      "total": 9000.00,
      "created_at": "2026-10-08T10:30:00Z"
    }
  ]
}
```

### `GET /api/orders/{id}`

Response `200`:

```json
{
  "id": 101,
  "checkout_id": 55,
  "status": "paid",
  "total": 9000.00,
  "items": [ { "product_id": 12, "name": "Paper Food Boxes", "quantity": 200, "unit_price": 45.00 } ],
  "delivery": { "address": "Riyadh, Saudi Arabia", "latitude": 24.7136, "longitude": 46.6753 }
}
```

Errors: `403` if the order belongs to someone else, `404` not found.

### `PUT /api/orders/{id}/status` (Supplier, owner)

Request:

```json
{ "status": "shipped" }
```

Allowed flow: `paid` to `processing` to `shipped` to `delivered`.
Response `200`: the updated order. Error: `400` invalid status change, `403` not the owner.

**Notes:** amounts are stored in SAR with two decimals. Moyasar expects the smallest currency unit (halalas), so the Backend converts SAR x 100 when calling Moyasar. Card details are never sent to or stored by the Backend.

---

## 4.9 Pricing Calculator Endpoint (Merchant)

### `POST /api/calculator/price`

Stateless: nothing is saved.

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

Response `200`:

```json
{
  "total_production_cost": 35.00,
  "cost_per_unit": 3.50,
  "suggested_price_per_unit": 5.00,
  "expected_profit_per_unit": 1.50
}
```

`profit_margin` is a percentage of the **selling price**:

```text
cost_per_unit   = total_production_cost / quantity
suggested_price = cost_per_unit / (1 - profit_margin / 100)
profit_per_unit = suggested_price - cost_per_unit
```

Validation: costs must be zero or more, `quantity > 0`, and `0 <= profit_margin < 100`. Otherwise the API returns `400`.

---

## 4.10 API Design Principles

- Use HTTP methods according to the operation (GET reads, POST creates, PUT updates, DELETE removes).
- Use resource-based endpoint names (`/products`, `/orders`) and plural nouns.
- Use JSON for all requests and responses, with consistent error messages and HTTP status codes.
- Validate all input on the Backend, even if the Frontend validates it too.
- Protect endpoints with JWT and check role and ownership.
- Keep **secret** keys (Moyasar secret key, JWT secret) on the Backend only. Public keys (Moyasar publishable key, Google Maps key restricted by domain) may be used in the Frontend.
- Never store card data. Only the Moyasar payment ID and status are saved.
- Confirm payments only through server-side verification with Moyasar, never from the browser.

## 4.11 API Summary

**Authentication, Profile, Products, Cart, Checkout and Payment, Orders, Pricing Calculator**

Together with the two external services (Google Maps and Moyasar), these endpoints support every Must Have user story in the MVP.















------
# 4. API Specifications

## Overview
All internal API routes start with `/api`.  
All requests and responses use standard JSON format. Protected endpoints require a valid JWT Bearer Token in the header.

---

## External APIs

* **Google Maps API:** Displays the interactive map on the frontend so merchants can pin their delivery address.
* **Moyasar API:** Handles credit card payment processing and webhook callbacks for order confirmation.

---

## Core Endpoints

### 1. Authentication
* `POST /api/auth/register` - Create a new user account (Merchant or Supplier).
* `POST /api/auth/login` - Authenticate user and return JWT token.

### 2. Products
* `GET /api/products` - Get product list (supports category filtering).
* `POST /api/products` - Add a new product (Suppliers only).

### 3. Cart & Checkout
* `POST /api/cart` - Add or update cart items.
* `POST /api/checkouts` - Convert cart into checkout orders and validate location.

### 4. Pricing Calculator
* `POST /api/calculator/price` - Calculate production costs, unit cost, suggested price, and net profit.

---

## Request & Response Example

### Endpoint: `POST /api/calculator/price`

**Request Payload:**
```json
{
  "material_cost": 20.0,
  "packaging_cost": 5.0,
  "labor_cost": 10.0,
  "quantity": 10,
  "profit_margin": 30
}
