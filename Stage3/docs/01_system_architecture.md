##  System Architecture

React.js frontend communicates with the Python Flask backend through REST APIs (using JSON format). The backend handles the core business logic, including the pricing calculator engine and order processing, while communicating with PostgreSQL via SQL/ORM for data management (Users, Businesses, Supplies, Costs, and Orders). Additionally, the system seamlessly integrates with external services, including Moyasar/Tap API for payment processing, Google Maps API for location-based logistics, and Supplier Services for raw material requests.

##  System Architecture

```mermaid
flowchart TB
    FE["React.js Frontend<br/>Merchant and Supplier UI"]
    NGINX["Nginx Reverse Proxy<br/>SSL and static assets"]
    BE["Python Flask Backend<br/>REST API and Business Logic<br/>(service layer: payment, maps)"]
    DB[("PostgreSQL Database<br/>Users, Products<br/>Carts, Orders, Payments")]
    PAY["Moyasar API<br/>Payment Processing"]
    MAPS["Google Maps API<br/>Location and Distance"]

    FE -->|"HTTPS"| NGINX
    NGINX -->|"REST API / JSON (JWT)"| BE
    BE -->|"SQL / SQLAlchemy ORM"| DB
    BE -->|"Create payment"| PAY
    PAY -.->|"Webhook: payment status"| BE
    BE -->|"Distance and delivery cost"| MAPS
    FE -->|"Load interactive map"| MAPS
```

 

```
