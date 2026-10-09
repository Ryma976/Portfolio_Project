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
```
 ##
 Response (200 OK):
```json
{
  "total_production_cost": 35.0,
  "cost_per_unit": 3.5,
  "suggested_price_per_unit": 5.0,
  "expected_profit_per_unit": 1.5
}
```
## Response Status Codes
**200 OK: Request succeeded.

**201 Created: New item successfully created.

**400 Bad Request: Invalid or missing input data.

**401 Unauthorized: Missing or expired JWT token.

**404 Not Found: Requested resource does not exist.
