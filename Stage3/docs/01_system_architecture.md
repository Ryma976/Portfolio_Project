# 1. System Architecture

## Architecture Overview
Maksab platform uses a **Three-Tier Architecture**:

* **Frontend:** Built with React.js (Single Page Application). It gives a fast UI for Merchants and Suppliers.
* **Backend:** Built with Python Flask. It handles the REST APIs, business logic, JWT authentication, and user roles.
* **Database:** PostgreSQL with SQLAlchemy ORM to store users, products, orders, and checkouts safely.
* **Proxy Server:** Nginx sits in front of Flask to handle HTTPS and reverse proxy.

---

## Technical Choices

* **React.js:** Good for interactive components like the pricing calculator and real-time cart.
* **Python Flask:** Lightweight and simple framework to build REST APIs quickly.
* **PostgreSQL:** Reliable relational database for financial transactions and order records.
* **Google Maps API:** Used by Merchants to pin their delivery location on the map.
* **Moyasar API:** Used for Saudi local payments (Mada and Visa).

---

## Data Flow Steps

1. **User Action:** The user performs an action on the React UI (e.g., login or checkout).
2. **HTTP Request:** React sends a REST API request (JSON payload + JWT token) to Flask via Nginx.
3. **Logic Processing:** Flask verifies the user role, checks validation rules (e.g., location inside Riyadh), and handles business logic.
4. **Database Operations:** Flask queries or saves data into PostgreSQL using SQLAlchemy ORM.
5. **Response:** Backend returns a JSON response to update the React interface.
```mermaid
graph TD
    subgraph Tier1["1. Presentation Tier (Frontend)"]
        ReactApp["React Single-Page Application (SPA)<br/>Merchant & Supplier UI"]
    end

    subgraph Tier2["2. Logic Tier (Backend)"]
        Nginx["Nginx Reverse Proxy<br/>(SSL Termination)"]
        
        subgraph FlaskApp["Python Flask REST API"]
            Auth["JWT Auth"]
            Products["Products Service"]
            Cart["Cart / Order Service"]
            Calc["Calculator Service"]
            Payment["Payment Service"]
        end
    end

    subgraph External["External Services"]
        GMaps["Google Maps API<br/>(Riyadh Boundary Check)"]
        Moyasar["Moyasar API<br/>(Payment Processing & Webhook)"]
    end

    subgraph Tier3["3. Data Tier (Persistence)"]
        Postgres[(PostgreSQL Database<br/>Users, Products, Carts,<br/>Checkouts, Orders, Payments)]
    end

    %% Flow Connections
    ReactApp -->|HTTPS / JSON| Nginx
    Nginx -->|REST API Request| FlaskApp
    
    FlaskApp -->|3a. Location Services| GMaps
    FlaskApp -->|3b. Process Payment / Webhook| Moyasar
    
    FlaskApp <-->|4. CRUD Operations / ORM| Postgres
```
