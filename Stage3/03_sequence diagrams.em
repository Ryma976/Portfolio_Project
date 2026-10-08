# System Architecture

## Overview

Maksab follows a **three-tier architecture**: a browser-based Single Page Application (SPA), a REST API backend, and a relational database. Two external services are integrated: **Moyasar** for payments and **Google Maps Platform** for location services. All communication between the front end and back end uses secure JSON over HTTPS.

## Architecture Diagram

```mermaid
flowchart TB
    User(["Merchant / Supplier"])

    subgraph Client["Presentation Tier: Browser"]
        SPA["SPA<br/>HTML5, CSS3/Tailwind, ES6+ JS<br/>Axios for API calls"]
    end

    subgraph Server["Application Tier: Backend REST API"]
        API["API Layer<br/>Routes + JWT Auth Middleware"]
        Auth["Auth Module"]
        Catalog["Catalog and Search Module"]
        Orders["Cart and Orders Module"]
        Calc["Pricing Calculator Module"]
        Pay["Payment Module"]
        Loc["Location Module"]
    end

    subgraph Data["Data Tier"]
        DB[("MySQL Database")]
        Files[("Image Storage<br/>product photos")]
    end

    subgraph External["External Services"]
        Moyasar["Moyasar<br/>Payment Gateway"]
        GMaps["Google Maps Platform<br/>Maps JS API, Distance"]
    end

    User --> SPA
    SPA -->|"1. HTTPS REST requests (JSON + JWT)"| API
    API -->|"2. JSON responses"| SPA

    API --> Auth
    API --> Catalog
    API --> Orders
    API --> Calc
    API --> Pay
    API --> Loc

    Auth -->|"3. SQL: users"| DB
    Catalog -->|"4. SQL: products"| DB
    Orders -->|"5. SQL: carts, orders"| DB
    Pay -->|"6. SQL: payments"| DB
    Catalog -->|"7. save / read images"| Files

    SPA -->|"8. load interactive map"| GMaps
    Loc -->|"9. distance and delivery cost"| GMaps
    Pay -->|"10. create payment"| Moyasar
    Moyasar -.->|"11. webhook: payment status"| Pay
```

## Data Flow

| # | From | To | Data |
| :--- | :--- | :--- | :--- |
| 1-2 | SPA | API Layer | Every action is a JSON REST request; the JWT token identifies the user and role. The API returns JSON. |
| 3 | Auth Module | MySQL | Register and login: user records with hashed passwords. |
| 4 | Catalog Module | MySQL | Suppliers create products; Merchants search and filter them. |
| 5 | Orders Module | MySQL | Cart items, orders, and order status. |
| 6 | Payment Module | MySQL | Payment records and transaction history. |
| 7 | Catalog Module | Image Storage | Product photos uploaded by Suppliers. |
| 8 | SPA | Google Maps | Merchant pins their location on the map (Riyadh only). |
| 9 | Location Module | Google Maps | Distance between Merchant and Supplier for the delivery cost estimate. |
| 10 | Payment Module | Moyasar | Order amount and payment request (sandbox mode in MVP). |
| 11 | Moyasar | Payment Module | Webhook confirming payment success or failure. The order becomes "Paid" only after this. |

## Component Responsibilities

| Component | Responsibility |
| :--- | :--- |
| **SPA** | UI for both roles, form validation, and API calls. |
| **API Layer** | Routing, JWT verification, role-based access (Merchant vs Supplier). |
| **Auth Module** | Registration, login/logout, password hashing. |
| **Catalog Module** | Product CRUD, search, filters. |
| **Orders Module** | Cart, checkout, order history, supplier order view. |
| **Pricing Calculator Module** | Production cost and suggested price. Stateless: it needs no database, which makes it easy to unit test. |
| **Payment Module** | Moyasar integration and webhook handling. |
| **Location Module** | Riyadh boundary validation, distance, and delivery cost. |

## Key Design Notes

- **Secrets stay on the server:** the Moyasar secret key is never exposed to the browser.
- **Payment confirmation comes from the webhook,** not from the browser redirect, so users cannot fake a paid order.
- **Modular monolith:** one deployable backend with separated modules. This fits a 4-person MVP and avoids the overhead of microservices.

