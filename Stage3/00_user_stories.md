# Task 0: User Stories, Scope & Mockups

## Project Overview
**Maksab (مَكْسَب)** is a B2B wholesale marketplace with a Smart Pricing Calculator for home-based merchants and wholesale suppliers in Riyadh, Saudi Arabia.

This document is aligned with the four MVP modules defined in Stage 2: **Smart Pricing Calculator**, **Wholesale Marketplace**, **Direct Payment Integration**, and **Location & Maps Services**.

---

## Target Roles

| Role | Description |
| :--- | :--- |
| **Merchant (الأسرة المنتجة)** | Home-based business owner sourcing wholesale raw materials and packaging. |
| **Supplier (المورد)** | Wholesale distributor listing supplies and fulfilling bulk orders. |

> **Note:** The Admin dashboard is out of scope for the MVP. Administration is handled directly through backend/database access by the developers.

---

## User Stories (20)

### 1. Authentication & Profile

| ID | Role | User Story | Priority |
| :--- | :--- | :--- | :--- |
| US-01 | Any | As a new user, I want to register and select my role (Merchant or Supplier), so that I can access features tailored to my business. | Must |
| US-02 | Any | As a registered user, I want to log in and log out securely, so that my cart, orders, and account stay protected. | Must |
| US-03 | Any | As a user, I want to manage my business profile (business name, contact info, delivery address), so that other parties can identify and contact me accurately. | Should |

### 2. Supplier Catalog & Order Management

| ID | Role | User Story | Priority |
| :--- | :--- | :--- | :--- |
| US-04 | Supplier | As a Supplier, I want to list wholesale products with photos, bulk price, description, and Minimum Order Quantity (MOQ), so that Merchants can discover and buy them. | Must |
| US-05 | Supplier | As a Supplier, I want to update product price and stock status (In Stock / Out of Stock), so that Merchants only order available items. | Should |
| US-06 | Supplier | As a Supplier, I want to view incoming paid orders, so that I know what to fulfill. | Must |
| US-07 | Supplier | As a Supplier, I want to update order status (Processing / Shipped / Delivered), so that Merchants can follow fulfillment. | Should |

### 3. Merchant Marketplace & Cart

| ID | Role | User Story | Priority |
| :--- | :--- | :--- | :--- |
| US-08 | Merchant | As a Merchant, I want to search products by item name or supplier name, so that I can find supplies quickly. | Must |
| US-09 | Merchant | As a Merchant, I want to filter products by category (raw materials, packaging) and price range, so that I can browse items within my budget. | Should |
| US-10 | Merchant | As a Merchant, I want to view a product details page with specifications and MOQ, so that I can make informed buying decisions. | Must |
| US-11 | Merchant | As a Merchant, I want to add/remove items and change quantities in a cart with a dynamic total, so that I can review my expenses before checkout. | Must |

### 4. Smart Pricing Calculator

| ID | Role | User Story | Priority |
| :--- | :--- | :--- | :--- |
| US-12 | Merchant | As a Merchant, I want to enter material, packaging, and labor/time costs, so that the calculator computes my exact production cost per unit. | Must |
| US-13 | Merchant | As a Merchant, I want to set a target profit margin, so that the calculator suggests a selling price and my expected profit per unit. | Must |

### 5. Location, Checkout & Payment

| ID | Role | User Story | Priority |
| :--- | :--- | :--- | :--- |
| US-14 | Merchant | As a Merchant, I want to pin my business location in Riyadh on an interactive Google Map, so that suppliers deliver to the correct address. | Must |
| US-15 | Merchant | As a Merchant, I want to pay for my order online through Moyasar, so that the transaction completes without cash handling. | Must |
| US-16 | Merchant | As a Merchant, I want to view my past orders and transaction history, so that I can track my business expenses. | Must |
| US-17 | Merchant | As a Merchant, I want to download a digital receipt for each order, so that I keep financial records. | Should |
| US-18 | Merchant | As a Merchant, I want to discover suppliers near my pinned location, so that I can reduce delivery time and cost. | Should |
| US-19 | Merchant | As a Merchant, I want to see an estimated delivery cost based on distance, so that I know the full order cost before paying. | Could |

### 6. Communication

| ID | Role | User Story | Priority |
| :--- | :--- | :--- | :--- |
| US-20 | Merchant / Supplier | As a Merchant, I want to message Suppliers in the app, so that I can ask about availability and bulk custom orders before buying. | Could |

---

## MoSCoW Prioritization Matrix

| Category | User Stories | Rationale |
| :--- | :--- | :--- |
| **Must Have** | US-01, 02, 04, 06, 08, 10, 11, 12, 13, 14, 15, 16 | The complete end-to-end core flow: register, list/browse, cart, pay, and supplier receives the order. Includes both pricing stories, because Stage 2 promises total cost, suggested price, and margin. |
| **Should Have** | US-03, 05, 07, 09, 17, 18 | Operational improvements that raise quality but do not block the core flow. |
| **Could Have** | US-19, US-20 | Desirable, but dropped first if time is short (see Scope Reduction Plan). |
| **Won't Have** | Admin dashboard, Saved recipe database, Live driver GPS tracking, Password reset | Excluded to keep the MVP focused on the B2B core flow within the project timeline. |

---

## Acceptance Criteria (Must Have)

**US-01 Register**
- User chooses a role (Merchant or Supplier) during registration.
- Duplicate emails are rejected with a clear message.
- Passwords are stored hashed.

**US-02 Login / Logout**
- Valid credentials return a session/token and redirect to the role's home screen.
- Invalid credentials show an error without revealing which field is wrong.
- Logout invalidates the session.

**US-04 List products**
- Supplier can submit name, photo, price, description, category, and MOQ.
- Required fields are validated; price and MOQ must be positive numbers.
- New product appears in the marketplace immediately.

**US-06 Incoming orders**
- Supplier sees only orders containing their own products.
- Each order shows items, quantities, total, payment status, and delivery location.

**US-08 Search**
- Search matches product name or supplier name.
- Empty results show a "no products found" message.

**US-10 Product details**
- Page shows photo, description, price, MOQ, and supplier name.
- Quantity below MOQ cannot be added to the cart.

**US-11 Cart**
- Add, remove, and quantity change update the total instantly.
- Cart persists after page refresh for a logged-in Merchant.

**US-12 Cost calculation**
- Inputs: materials, packaging, labor/time.
- Output: total cost per unit, verified against documented test cases.
- Negative or empty inputs are rejected.

**US-13 Suggested price**
- Merchant enters a margin percentage.
- Output: suggested selling price and expected profit per unit.
- Formula and test cases are documented.

**US-14 Location pin**
- Merchant can drop and move a pin on Google Maps.
- A location outside the Riyadh boundary is rejected with a message.
- Saved coordinates attach to the order.

**US-15 Payment (Moyasar)**
- Merchant is redirected to Moyasar and returned with a success or failure status.
- The order is marked "Paid" only after payment confirmation.
- A failed payment keeps the cart intact.
- MVP runs in **sandbox/test mode**.

**US-16 Order history**
- Merchant sees a list of their own orders with date, total, and status.

---

## Mockups (Main Screens)

The linked screenshots are preview captures from the [published Figma prototype](https://prong-high-33840094.figma.site/), not direct Figma deep links to individual screens.

| # | Screen | Covers | Link / Image |
| :--- | :--- | :--- | :--- |
| 1 | Login / Register (role selection) | US-01, 02 | [Preview](images/mockups/01_auth_role.png) |
| 2 | Marketplace (search, filters, product list) | US-08, 09 | [Preview](images/mockups/02_marketplace.png) |
| 3 | Product details | US-10 | [Preview](images/mockups/03_product_details.png) |
| 4 | Cart | US-11 | [Preview](images/mockups/04_cart.png) |
| 5 | Checkout (map + payment) | US-14, 15 | [Preview](images/mockups/05_checkout_map_payment.png) |
| 6 | Smart Pricing Calculator | US-12, 13 | [Preview](images/mockups/06_pricing_calculator.png) |
| 7 | Supplier dashboard (add product, incoming orders) | US-04, 06 | [Preview](images/mockups/07_supplier_dashboard.png) |
| 8 | Order history | US-16, 17 | [Preview](images/mockups/08_order_history.png) |

Figma link: [Figma site](https://prong-high-33840094.figma.site/)

---

## Scope Reduction Plan

If time runs short, features are cut in this order:
1. US-20 In-app messaging (Stage 2 lists it as part of the marketplace; it is deferred to a later phase).
2. US-19 Delivery cost by distance.
3. US-18 Supplier discovery by location.
4. US-17 Receipt download.

Payment stays in **Moyasar sandbox mode** for the MVP.

---

## Traceability to Stage 2 Modules

| Stage 2 Module | Stories |
| :--- | :--- |
| Smart Pricing Calculator | US-12, US-13 |
| Wholesale Marketplace | US-04, 05, 06, 07, 08, 09, 10, 11, 20 |
| Direct Payment Integration | US-15, 16, 17 |
| Location & Maps Services | US-14, 18, 19 |
