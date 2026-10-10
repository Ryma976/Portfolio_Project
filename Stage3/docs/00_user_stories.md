# Task 0: User Stories, Scope & Mockups

## Scope

Maksab is a wholesale marketplace (B2B) that connects home-based merchants with wholesale suppliers in Riyadh. Merchants can also use a pricing calculator to know their cost and how much to sell for.

For the MVP we are working on the four modules from Stage 2:
- Smart Pricing Calculator
- Wholesale Marketplace
- Direct Payment with Moyasar (test mode)
- Location & Maps: Google Maps and delivery fee by distance

The users are:
- **Merchant (الأسرة المنتجة):** has a home business and buys raw materials and packaging in bulk.
- **Supplier (المورد):** sells wholesale and takes care of the orders.

No admin dashboard for now. We will manage the data from the backend/database ourselves.

---

## User Stories

### Account

| ID | Role | User Story | Priority |
| --- | --- | --- | --- |
| US-01 | Any | As a new user, I want to sign up and pick my role (Merchant or Supplier), so I only see what fits me. | Must |
| US-02 | Any | As a user, I want to log in and log out, so my orders stay private. | Must |

### Supplier

| ID | Role | User Story | Priority |
| --- | --- | --- | --- |
| US-03 | Supplier | As a Supplier, I want to add my products with a photo, price, description and the minimum order quantity (MOQ), so merchants can buy them. | Must |
| US-04 | Supplier | As a Supplier, I want to edit the price or mark a product as out of stock, so nobody orders something I don't have. | Should |
| US-05 | Supplier | As a Supplier, I want to see my new paid orders, so I know what to prepare. | Must |
| US-06 | Supplier | As a Supplier, I want to change the order status (Processing, Shipped, Delivered), so the merchant can follow it. | Should |

### Merchant: Marketplace & Cart

| ID | Role | User Story | Priority |
| --- | --- | --- | --- |
| US-07 | Merchant | As a Merchant, I want to search for products, so I find them fast. | Must |
| US-08 | Merchant | As a Merchant, I want to filter by category and see only what's in stock. | Should |
| US-09 | Merchant | As a Merchant, I want to open a product and see its details and MOQ before I buy. | Must |
| US-10 | Merchant | As a Merchant, I want to add or remove items and change the quantity in my cart, and see the total change right away, so I know how much I'm paying. | Must |

### Merchant: Pricing Calculator

| ID | Role | User Story | Priority |
| --- | --- | --- | --- |
| US-11 | Merchant | As a Merchant, I want to enter my costs (materials, packaging and my working time), so I know how much one piece really costs me. | Must |
| US-12 | Merchant | As a Merchant, I want to enter the profit % I want, so the calculator gives me a selling price and my profit per piece. | Must |

### Merchant: Checkout & Orders

| ID | Role | User Story | Priority |
| --- | --- | --- | --- |
| US-13 | Merchant | As a Merchant, I want to pin my location on the map, so the supplier delivers to the right place. | Must |
| US-14 | Merchant | As a Merchant, I want to see the delivery fee (based on distance) before paying. | Must |
| US-15 | Merchant | As a Merchant, I want to pay online with Moyasar instead of cash. | Must |
| US-16 | Merchant | As a Merchant, I want to see my old orders and their status, so I can follow them and know how much I spent. | Must |

---

## MoSCoW Prioritization

| Priority | Stories | Why |
| --- | --- | --- |
| Must Have | US-01, 02, 03, 05, 07, 09, 10, 11, 12, 13, 14, 15, 16 | This is the main flow. Without it the merchant can't buy and the supplier can't get the order. The calculator and delivery fee are part of Stage 2, so they are Must too. |
| Should Have | US-04, 06, 08 | Good to have, but the app still works without them. |
| Could Have | None | |
| Won't Have (for now) | Admin dashboard, chat, favorites, saved recipes, receipt download, nearby suppliers, live delivery tracking, password reset | Not in this version because of the time we have. |

---

## Mockups

Figma: https://prong-high-33840094.figma.site

| # | Screen | Stories | Image |
| --- | --- | --- | --- |
| 1 | Sign up / Login | US-01, 02 | [01-auth-role.png](../images/01-auth-role.png) |
| 2 | Marketplace | US-07, 08 | [02-marketplace.png](../images/02-marketplace.png) |
| 3 | Product details | US-09 | [03-product-details.png](../images/03-product-details.png) |
| 4 | Cart | US-10 | [04-cart.png](../images/04-cart.png) |
| 5 | Checkout (map, delivery fee, payment) | US-13, 14, 15 | [05-checkout-map.png](../images/05-checkout-map.png) |
| 6 | Pricing calculator | US-11, 12 | [06-pricing-calculator.png](../images/06-pricing-calculator.png) |
| 7 | Supplier dashboard | US-03, 04, 05, 06 | [07-supplier-dashboard.png](../images/07-supplier-dashboard.png) |
| 8 | My orders | US-16 |
