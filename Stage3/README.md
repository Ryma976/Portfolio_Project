
# Stage 3 Report: Technical Documentation Blueprint

**Portfolio Project – Holberton Saudi Arabia**

**Project:** Maksab (مَكْسَب) – Platform for Home-Based & Family-Production Businesses in Saudi Arabia

**Team:** Reem Alanazi, Bayadir Aldossari, Shomukh Aldosari, Shahad Alharbi

**Document Version:** 1.0


---

## 0. User Stories and Prioritization (MoSCoW)

###  User Roles (Personas)
To maintain clarity across all user stories, the following terms represent the primary actors of the **Maksab (مَكْسَب)** platform:
* **Merchant:** A home-based business owner who uses Maksab to calculate product costs, manage recipes, and source wholesale supplies.
* **Supplier:** A verified vendor who lists raw materials and packaging supplies on the platform.

---

###  Prioritized User Stories

| Priority | ID | User Story |
| --- | --- | --- |
| **Must Have** | `US-01` | **As a** Merchant, **I want to** enter raw material costs, packaging costs, and labor time into a calculator, **so that** I can determine the exact production cost, suggested retail price, and profit margin. |
| **Must Have** | `US-02` | **As a** Merchant, **I want to** save my product pricing recipes to my account, **so that** I can reload, edit, or track my recipe costs over time. |
| **Must Have** | `US-03` | **As a** Merchant, **I want to** browse and filter a wholesale catalog of raw materials and packaging, **so that** I can source supplies directly from Saudi suppliers. |
| **Must Have** | `US-04` | **As a** Merchant, **I want to** add wholesale items to an interactive shopping cart and review my order summary, **so that** I can calculate my total sourcing costs before checking out. |
| **Must Have** | `US-05` | **As a** Merchant, **I want to** select my delivery location in Riyadh on an interactive map during checkout, **so that** my shipping costs are calculated based on my exact distance from the supplier. |
| **Must Have** | `US-06` | **As a** Merchant, **I want to** pay for my wholesale order online using Mada or Credit Card, **so that** my purchase is secured and confirmed immediately. |
| **Should Have** | `US-07` | **As a** Supplier, **I want to** list my raw materials and packaging products on the platform, **so that** merchants can discover and order them. |
| **Should Have** | `US-08` | **As a** Merchant, **I want to** send direct inquiry messages to suppliers regarding wholesale products, **so that** I can negotiate bulk customizations. |
| **Could Have** | `US-09` | **As a** Merchant, **I want to** sort suppliers by proximity to my selected location, **so that** I can minimize shipping time and delivery fees. |
| **Won't Have** | `US-10` | **As a** Merchant, **I want to** track my delivery driver in real time on a live GPS map, **so that** I know the exact arrival minute. |





---


## 🏛️ System Architecture

React.js frontend communicates with the Python Flask backend through REST APIs (using JSON format). The backend handles the core business logic, including the pricing calculator engine and order processing, while communicating with PostgreSQL via SQL/ORM for data management (Users, Businesses, Supplies, Costs, and Orders). Additionally, the system seamlessly integrates with external services, including Moyasar/Tap API for payment processing, Google Maps API for location-based logistics, and Supplier Services for raw material requests.

##  System Architecture
```mermaid
flowchart TB

    %% Frontend
    A[" React.js Frontend<br/>User Interface"] 
    
    %% Backend
    B[" Python Flask Backend<br/>REST API & Business Logic"]

    %% Database
    C[(" PostgreSQL Database<br/>Users • Businesses • Products • Orders")]

    %% External Services
    D[" Moyasar / Tap API<br/>Payment Processing"]
    E[" Google Maps API<br/>Location & Maps"]

    %% Main Flow
    A -->|"REST API / JSON"| B
    B -->|"SQL / ORM"| C

    %% External APIs
    B -->|"Payment API"| D
    B -->|"Maps API"| E

    %% Styling
    classDef frontend fill:#E3F2FD,stroke:#1976D2,stroke-width:2px,color:#0D47A1
    classDef backend fill:#E8F5E9,stroke:#388E3C,stroke-width:2px,color:#1B5E20
    classDef database fill:#FFF3E0,stroke:#F57C00,stroke-width:2px,color:#E65100
    classDef external fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C

    class A frontend
    class B backend
    class C database
    class D,E external
```
##  MAKSAB System Architecture

```mermaid
flowchart TB

    A[" React.js Frontend<br/>MAKSAB Web Platform"]

    B[" Python Flask Backend<br/>REST API & Business Logic"]

    C[(" PostgreSQL Database<br/>
    Users • Home Businesses<br/>
    Materials • Suppliers<br/>
    Costs • Orders")]

    D[" Supplier Services<br/>Supplier & Material Data"]

    E[" Moyasar / Tap API<br/>Payment Processing"]

    F[" Google Maps API<br/>Supplier Locations"]

    A -->|"REST API / JSON"| B

    B -->|"SQL / ORM"| C

    B -->|"Supplier & Material Requests"| D

    B -->|"Payment API"| E

    B -->|"Maps API"| F

    classDef frontend fill:#E3F2FD,stroke:#1976D2,stroke-width:2px,color:#0D47A1
    classDef backend fill:#E8F5E9,stroke:#388E3C,stroke-width:2px,color:#1B5E20
    classDef database fill:#FFF3E0,stroke:#F57C00,stroke-width:2px,color:#E65100
    classDef external fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C

    class A frontend
    class B backend
    class C database
    class D,E,F external
```



###  Architectural Decisions & Rationale

* **React.js (Single Page Application):** Provides a smooth, highly responsive UI for complex interactive modules like the Smart Pricing Calculator, live wholesale shopping cart, and location picker without triggering full-page reloads.


* **Flask RESTful API (Python):** Chosen for its lightweight footprint and modular structure. Flask simplifies the implementation of the **Facade Structural Pattern**, allowing us to isolate external integrations behind clean, reusable API controllers.


* **PostgreSQL & SQLAlchemy ORM:** Offers structured relational storage with strong ACID compliance, ensuring relational integrity across users, wholesale orders, line items, and financial calculations.


* **Nginx Reverse Proxy:** Manages SSL termination, serves compiled frontend assets, and acts as a gateway proxy to protect Flask application processes.

---

##  2. Data Model (Entity-Relationship)

### 2.1 Entity-Relationship (ER) Diagram

```
+-----------------------------------+        +-----------------------------------+
|               USERS               |        |             PRODUCTS              |
+-----------------------------------+        +-----------------------------------+
| id            | UUID (PK)         |        | id            | UUID (PK)         |
| full_name     | VARCHAR(100)      |        | supplier_id   | UUID (FK -> USERS)|
| email         | VARCHAR(255) (UQ) |        | name          | VARCHAR(255)      |
| password_hash | VARCHAR(255)      |        | category      | VARCHAR(50)       |
| phone         | VARCHAR(20)       |        | unit_price    | DECIMAL(10,2)     |
| role          | VARCHAR(20)       |        | moq           | INT               |
| created_at    | TIMESTAMPTZ       |        | image_url     | VARCHAR(512)      |
+-----------------+-----------------+        +-----------------+-----------------+
                  |                                            |
                  | 1                                          | 1
                  |                                            |
                  | N                                          | N
+-----------------+-----------------+        +-----------------+-----------------+
|          PRICING_RECIPES          |        |            ORDER_ITEMS            |
+-----------------------------------+        +-----------------------------------+
| id            | UUID (PK)         |        | id            | UUID (PK)         |
| user_id       | UUID (FK -> USERS)|        | order_id      | UUID (FK -> ORDERS|
| recipe_name   | VARCHAR(150)      |        | product_id    | UUID (FK -> PROD) |
| material_cost | DECIMAL(10,2)     |        | quantity      | INT               |
| packaging_cost| DECIMAL(10,2)     |        | unit_price    | DECIMAL(10,2)     |
| labor_hours   | DECIMAL(5,2)      |        +-----------------------------------+
| hourly_rate   | DECIMAL(10,2)     |                          ^
| total_cost    | DECIMAL(10,2)     |                          | N
| suggested_price| DECIMAL(10,2)    |                          |
| profit_margin | DECIMAL(5,2)      |                          | 1
+-----------------------------------+        +------------------+----------------+
                                             |              ORDERS               |
                                             +-----------------------------------+
                                             | id            | UUID (PK)         |
                                             | user_id       | UUID (FK -> USERS)|
                                             | total_amount  | DECIMAL(10,2)     |
                                             | shipping_fee  | DECIMAL(10,2)     |
                                             | status        | VARCHAR(20)       |
                                             | delivery_addr | TEXT              |
                                             | latitude      | DECIMAL(10,8)     |
                                             | longitude     | DECIMAL(10,8)     |
                                             | payment_ref   | VARCHAR(255)      |
                                             | created_at    | TIMESTAMPTZ       |
                                             +-----------------------------------+

```
```mermaid

erDiagram

    USERS ||--o| SUPPLIER_PROFILES : has
    USERS ||--o{ PRODUCTS : supplies
    USERS ||--o{ PRICING_RECIPES : saves
    USERS ||--o{ ORDERS : places
    USERS ||--o{ ORDERS : fulfils
    USERS ||--o{ MESSAGES : sends
    USERS ||--o{ MESSAGES : receives
    PRODUCTS ||--o{ ORDER_ITEMS : appears
    PRODUCTS ||--o{ MESSAGES : concerns
    ORDERS ||--|{ ORDER_ITEMS : contains
    ORDERS ||--o{ PAYMENTS : settled

    USERS {
        uuid id PK
        varchar full_name
        varchar email UK
        varchar password_hash
        varchar role
        timestamptz created_at
    }

    SUPPLIER_PROFILES {
        uuid user_id PK, FK
        varchar business_name
        text address
        varchar city
        decimal_10_8 latitude
        decimal_11_8 longitude
        boolean is_verified
    }

    PRODUCTS {
        uuid id PK
        uuid supplier_id FK
        varchar name
        varchar category
        varchar unit
        decimal_10_2 unit_price
        int moq
        varchar image_url
        boolean is_active
        timestamptz created_at
    }

    PRICING_RECIPES {
        uuid id PK
        uuid user_id FK
        varchar recipe_name
        decimal_10_2 material_cost
        decimal_10_2 packaging_cost
        decimal_5_2 labor_hours
        decimal_10_2 hourly_rate
        decimal_5_2 desired_margin
        decimal_10_2 total_cost
        decimal_10_2 suggested_price
        decimal_10_2 net_profit
        timestamptz created_at
        timestamptz updated_at
    }

    ORDERS {
        uuid id PK
        uuid user_id FK
        uuid supplier_id FK
        decimal_10_2 subtotal
        decimal_10_2 shipping_fee
        decimal_10_2 total_amount
        varchar status
        text delivery_addr
        varchar city
        decimal_10_8 latitude
        decimal_11_8 longitude
        timestamptz created_at
        timestamptz updated_at
    }

    ORDER_ITEMS {
        uuid id PK
        uuid order_id FK
        uuid product_id FK
        int quantity
        decimal_10_2 unit_price
    }

    PAYMENTS {
        uuid id PK
        uuid order_id FK
        varchar moyasar_id UK
        decimal_10_2 amount
        varchar currency
        varchar method
        varchar status
        timestamptz paid_at
        timestamptz created_at
    }

    MESSAGES {
        uuid id PK
        uuid sender_id FK
        uuid recipient_id FK
        uuid product_id FK
        text body
        boolean is_read
        timestamptz created_at
    }

    

```
---

##  3. Sequence Diagram

### Wholesale Order, Distance Calculation & Payment Flow

```
User (Client)         React Frontend          Flask API            Google Maps API       Moyasar Payment API        Database
    |                       |                     |                       |                     |                      |
    |-- Select Location --->|                     |                       |                     |                      |
    |   on Pin Map          |-- Get Distance ---->|                       |                     |                      |
    |                       |   & Calculate Fee   |-- Calculate Matrix -->|                     |                      |
    |                       |                     |<-- Distance & Time ---|                     |                      |
    |                       |<-- Return Dist/Fee -|                       |                     |                      |
    |                       |                     |                       |                     |                      |
    |-- Click "Pay Now" ---->|                     |                       |                     |                      |
    |                       |-- POST /orders ---->|                       |                     |                      |
    |                       |   (Items + Address) |-- Insert Pending Order ----------------------------------------->|
    |                       |                     |<-- Order ID Created -----------------------------------------------|
    |                       |                     |                       |                     |                      |
    |                       |                     |-- Initialize Invoice ---------------------->|                      |
    |                       |                     |<-- Payment URL / Session -------------------|                      |
    |                       |<-- Redirect Page ---|                       |                     |                      |
    |                       |                     |                       |                     |                      |
    |-- Completes Payment ->|                     |                       |                     |                      |
    |   on Moyasar Gateway  |-- Webhook Callback -|                       |                     |                      |
    |                       |   Verification ---->|-- Verify Transaction ---------------------->|                      |
    |                       |                     |<-- Status: Paid ----------------------------|                      |
    |                       |                     |                                                                    |
    |                       |                     |-- Update Order Status to "Paid" ---------------------------------->|
    |                       |<-- 200 OK (Invoice)-|                                                                    |
    |<-- Order Confirmed ---|                     |                                                                    |

```

---

##  4. API Specifications

### 4.1 External Third-Party Integrations

1. **Moyasar / Tap Payment API:**

* **Purpose:** Direct online payment gateway processing using Mada, Visa, and Mastercard for wholesale orders.


* **Endpoint:** `POST [https://api.moyasar.com/v1/payments](https://api.moyasar.com/v1/payments)`
* **Authentication:** HTTP Basic Auth using API Secret Key.


2. **Google Maps Distance Matrix & Geocoding API:**

* **Purpose:** Translates map pin locations into structured Riyadh addresses and calculates driving distance to determine dynamic shipping fees.


* **Endpoint:** `GET [https://maps.googleapis.com/maps/api/distancematrix/json](https://maps.googleapis.com/maps/api/distancematrix/json)`



---

### 4.2 Internal API Endpoints

#### 1. Smart Pricing Calculator

* **HTTP Method:** `POST`
* **Endpoint:** `/api/v1/calculator/calculate`
* **Request Headers:** `Content-Type: application/json`
* **Request Body:**

```json
{
  "materialCost": 45.00,
  "packagingCost": 10.00,
  "laborHours": 2.5,
  "hourlyRate": 20.00,
  "desiredMarginPercentage": 35.0
}

```

* **Success Response (`200 OK`):**

```json
{
  "status": "success",
  "data": {
    "totalProductionCost": 105.00,
    "suggestedRetailPrice": 161.54,
    "netProfit": 56.54,
    "marginPercentage": 35.0
  }
}

```

#### 2. Create Wholesale Order

* **HTTP Method:** `POST`
* **Endpoint:** `/api/v1/orders`
* **Request Headers:**
* `Content-Type: application/json`
* `Authorization: Bearer <JWT_TOKEN>`


* **Request Body:**

```json
{
  "items": [
    {
      "productId": "d3b07384-d113-42e2-9b2d-9b57683939a2",
      "quantity": 10
    }
  ],
  "shippingAddress": {
    "street": "King Fahd Road",
    "city": "Riyadh",
    "latitude": 24.7136,
    "longitude": 46.6753
  }
}

```

* **Success Response (`201 Created`):**

```json
{
  "status": "success",
  "data": {
    "orderId": "e4c56789-e12b-34cd-56ef-789012345678",
    "subtotal": 500.00,
    "shippingFee": 35.00,
    "totalAmount": 535.00,
    "status": "pending_payment",
    "paymentUrl": "https://api.moyasar.com/v1/invoice/sample_token"
  }
}

```

---

## 🛠️ 5. SCM and QA Strategies

### 5.1 Source Control Management (SCM)

```
         +----------------------------------------------------------+
         |                    main (Production)                     |
         +----------------------------------------------------------+
                                      ^
                                      | Production Release PR
                                      |
         +----------------------------------------------------------+
         |                 development (Staging)                    |
         +----------------------------------------------------------+
                  ^                                ^
                  | Feature PR                     | Feature PR
                  |                                |
  +---------------+---------------+  +-------------+----------------+
  |  feature/pricing-calculator   |  |   feature/wholesale-cart     |
  +-------------------------------+  +------------------------------+

```

* **Branching Model:** Modified GitFlow featuring `main`, `development`, and task-specific `feature/*` branches.
* **Commit Guidelines:** Follows Conventional Commits (e.g., `feat(calculator): add profit margin logic`, `fix(api): handle missing shipping coordinate edge cases`).
* **Pull Request (PR) Policy:**
* Direct pushes to `main` and `development` are restricted.


* Requires **at least 1 peer review approval** from team leads (Bayadir / Reem).


* Automated CI pipeline must pass before merging.



### 5.2 Quality Assurance (QA) Strategy

* **Frontend Unit & Component Testing:** Jest and React Testing Library to test pricing calculator rendering, state updates, and cart item modifications.
* **Backend Integration Testing:** PyTest executed against an isolated PostgreSQL test database to verify REST API responses and calculation accuracy.
* **Code Style Enforcers:**
* **Backend:** Flake8 (PEP 8 compliance).
* **Frontend:** ESLint (Airbnb JavaScript Style Guide) + Prettier.


* **Continuous Integration (CI):** GitHub Actions executing on every Pull Request:
1. `npm run lint` & `flake8 .` (Static Code Analysis)
2. `pytest` (Backend Unit & Integration Tests)
3. `npm test` (React Component Tests)



---

##  6. Technical Rationales & Justifications

* **React + Flask Decoupled Architecture:** Provides clear technical separation between backend data processing (Shahad) and frontend UI management (Shomukh), enabling concurrent feature development without code collisions.


* **PostgreSQL over NoSQL:** Financial accounting for production pricing and multi-item wholesale orders demands strong ACID guarantees and relational constraints, making PostgreSQL the safest choice.


* **Facade Structural Pattern:** Abstracts third-party complexities (Moyasar payment webhooks, Google Maps distance matrix calculations) behind clean internal Flask controllers, keeping the codebase maintainable and testable.
