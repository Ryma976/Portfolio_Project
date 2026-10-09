# API Specifications

## 1. Overview

Maksab uses a Flask backend to handle requests from the frontend.
The frontend sends requests to the backend to get product information,
manage cart items, calculate prices, and place orders.

The API uses JSON to exchange data between the frontend and backend.
Some routes require a JWT token so the system can identify the logged-in user.

The API routes start with `/api`.

## 2. Authentication

### POST /api/auth/register

Creates a new account for a merchant or supplier.

The user provides the information needed to create an account.
The backend checks the submitted data before saving the account.

### POST /api/auth/login

Checks the user's login information.

If the information is correct, the backend returns a JWT token.
The frontend uses this token when accessing protected routes.

### GET /api/users/me

Returns information about the currently logged-in user.

A valid JWT token is required.

## 3. Categories and Products

### GET /api/categories

Returns the available product categories.

Merchants can use the categories to find the materials they need.

### GET /api/products

Returns the products available on Maksab.

The request can include a category filter to help merchants find
specific materials or products.

### GET /api/products/{product_id}

Returns the details of a selected product.

The response may include the product name, price, description,
and supplier information.

### POST /api/products

Allows a supplier to add a new product.

The backend checks the submitted product information before saving it.
Only suppliers with the required permissions can use this route.

### PATCH /api/products/{product_id}

Updates the details of a product owned by the supplier.

The backend checks that the supplier has permission to update the product.

### DELETE /api/products/{product_id}

Removes a product owned by the supplier.

The backend checks ownership before processing the request.

## 4. Cart

### GET /api/cart

Returns the current user's cart and its items.

### POST /api/cart/items

Adds a product to the cart or updates its quantity,
depending on the agreed cart design.

### PATCH /api/cart/items/{item_id}

Changes the quantity of an item already in the cart.

The backend checks that the quantity is valid.

### DELETE /api/cart/items/{item_id}

Removes an item from the cart.

The user can manage items from different suppliers
before moving to checkout.

## 5. Checkout and Payments

### POST /api/checkouts

Creates a checkout from the items in the cart.

The backend checks the selected products, quantities, prices,
and other required information.

If the cart contains products from different suppliers,
the checkout can create a separate order for each supplier.
The merchant completes one payment for the checkout.

### GET /api/checkouts/{checkout_id}

Returns the details and payment status of a checkout.

The backend checks that the user is allowed to access the checkout.

### POST /api/checkouts/{checkout_id}/payment

Starts the payment process for a checkout using Moyasar.

The backend prepares the payment request and returns the information
needed by the frontend to continue the payment process.

The payment integration will use Moyasar's Sandbox environment during testing.

### POST /api/webhooks/moyasar

Receives payment notifications from Moyasar.

The backend validates the notification and verifies the payment status
and amount with Moyasar before updating the checkout and related orders.

The webhook must not rely only on information sent by the browser.

## 6. Orders

### GET /api/orders

Returns the orders belonging to the logged-in merchant.

### GET /api/orders/{order_id}

Returns the details of a selected order.

The backend checks that the user has permission to view it.

### GET /api/supplier/orders

Returns the orders assigned to the logged-in supplier.

This allows suppliers to view orders that contain their products.

### PATCH /api/supplier/orders/{order_id}/status

Allows a supplier to update the status of an order they are responsible for.

The backend checks the supplier's permissions and validates the new status
before saving the change.

## 7. Smart Pricing Calculator

### POST /api/calculator/price

Calculates the production cost and suggested selling price
for a product.

The request includes the material cost, packaging cost, labor cost,
number of units produced, and desired profit margin.

The backend calculates the total production cost, cost per unit,
suggested selling price, and expected profit per unit.

#### Example Request

{
  "material_cost": 20.0,
  "packaging_cost": 5.0,
  "labor_cost": 10.0,
  "quantity": 10,
  "profit_margin": 30
}

In this example, the costs are the total costs for producing 10 units.
The profit margin is entered as a percentage.

#### Example Response

{
  "total_production_cost": 35.0,
  "cost_per_unit": 3.5,
  "suggested_price_per_unit": 5.0,
  "expected_profit_per_unit": 1.5
}

The total production cost is 35 SAR, and the cost per unit is 3.50 SAR.
With a 30% profit margin based on the selling price, the suggested
selling price is 5.00 SAR per unit.

## 8. External APIs

### Moyasar

Moyasar is used to process payments.

Maksab uses the Sandbox environment for payment testing.
The backend verifies payment information before confirming an order.

Card details should not be stored in the Maksab database.

### Google Maps

Google Maps is used to display an interactive map and help merchants
select or mark a location.

The exact integration depends on the final frontend and backend design.

## 9. HTTP Status Codes

The API may return the following status codes:

- `200 OK` — The request was completed successfully.
- `201 Created` — A new resource was created.
- `400 Bad Request` — The request contains invalid information.
- `401 Unauthorized` — The user is not authenticated or the token is invalid.
- `403 Forbidden` — The user does not have permission to perform the action.
- `404 Not Found` — The requested resource does not exist.
- `500 Internal Server Error` — An unexpected server error occurred.

Error responses should include a message explaining what went wrong.
