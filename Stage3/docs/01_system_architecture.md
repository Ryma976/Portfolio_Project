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
# 1. System Architecture

## Overview
Maksab uses a **Three-Tier Architecture** to separate the user interface, backend processing, and data storage. This setup keeps the application organized and easy to maintain.

---

## 1.1 High-Level Architecture Diagram

```mermaid
graph TD
    subgraph Frontend["1. Presentation Tier"]
        ReactApp["React.js SPA<br/>(Merchant & Supplier UI)"]
    end

    subgraph Backend["2. Logic Tier"]
        Nginx["Nginx Reverse Proxy"]
        
        subgraph Flask["Python Flask API"]
            AuthService["JWT Auth Module"]
            ProductService["Products Module"]
            CartService["Cart & Order Module"]
            CalcService["Pricing Calculator Module"]
            PaymentService["Payment Module"]
        end
    end

    subgraph External["External Services"]
        GoogleMaps["Google Maps API"]
        Moyasar["Moyasar Payment API"]
    end

    subgraph Database["3. Data Tier"]
        Postgres[(PostgreSQL Database)]
    end

    %% Data Flow
    ReactApp -->|HTTPS / JSON Requests| Nginx
    Nginx -->|Forward Requests| Flask
    
    Flask -->|Validate Riyadh Boundary| GoogleMaps
    Flask -->|Process Payment & Webhook| Moyasar
    
    Flask <-->|Read / Write Data (SQLAlchemy)| Postgres
```
