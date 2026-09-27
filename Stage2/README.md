# Stage 2: Project Charter

## 📌 Project Information

**Project:** Maksab (مَكْسَب)  
**Stage:** Stage 2 – Project Charter  
**Date:** September 2026

### 👥 Team Members

- **Bayadir Aldossari** — Project Manager & Full-Stack Lead
- **Reem Alanazi** — Technical & Architecture Lead
- **Shomukh Aldosari** — Lead Frontend Engineer
- **Shahad Alharbi** — Lead Backend Engineer

---

# 1. Project Objectives

## Purpose

Maksab is a digital platform designed for Saudi home-based and
family-production businesses. It helps entrepreneurs calculate product
costs, find wholesale suppliers and business resources, and access
services that support their business growth.

## Objectives

- **Smart Pricing:** By the final project presentation, deliver a pricing
  calculator that accepts material, packaging, and labor costs and displays
  the total production cost, suggested selling price, and profit margin. Verify
  its calculations using documented test cases.

- **Wholesale Sourcing:** By the final project presentation, provide a
  searchable and filterable catalog of wholesale raw materials and packaging,
  with a cart that displays the selected items and an estimated total. Verify
  this flow with documented test cases.



---

# 2. Stakeholders and Team Roles

## Stakeholders

| Stakeholder | Type | Role |
|---|---|---|
| Bayadir Aldossari | Internal | Project Manager & Full-Stack Lead |
| Reem Alanazi | Internal | Technical & Architecture Lead |
| Shomukh Aldosari | Internal | Lead Frontend Engineer |
| Shahad Alharbi | Internal | Lead Backend Engineer |
| Project Instructor / Tutor | Internal | Guidance, feedback, and evaluation |
| Home-Based Businesses | External | Primary target users |
| Suppliers | External | Provide raw materials and packaging products |

## Team Responsibilities

### Bayadir Aldossari
- Project coordination and planning.
- Task and progress tracking.
- Team communication and scheduling.

### Reem Alanazi
- Technical direction.
- Software architecture.
- Frontend and backend integration.
- Technical decision-making.

### Shomukh Aldosari
- Frontend development.
- User interface implementation.
- Responsive web design.
- Frontend functionality.

### Shahad Alharbi
- Backend development.
- REST API implementation.
- Database integration.
- Server-side business logic.

---

# 3. Project Scope

## 3.1 In-Scope

The MVP will focus on the **Mediator Platform Model** connecting home-based businesses with wholesale suppliers, and will include four core modules:

### 🧮 1. Smart Pricing Calculator
* Material cost input.
* Packaging cost input.
* Labor/time cost input.
* Automated production cost calculation.
* Suggested selling price & profit margin calculation.

### 📦 2. Wholesale Marketplace
* Raw-material and packaging supplier listings.
* Wholesale product catalog with search and filtering.
* Interactive shopping cart & total order cost estimation.
* Direct messaging/inquiry channel between home businesses and suppliers.

### 💳 3. Live Payment Integration
* Direct online payment gateway integration (**Moyasar / Tap API**).
* Secure transaction processing for wholesale orders.
* Digital order receipts and transaction history.

### 📍 4. Location & Maps Services
* Integrated **Google Maps API** for precise location selection in Riyadh.
* Location-based supplier discovery.
* Dynamic estimated delivery cost calculation based on distance.





### 3.2 Technical Scope

* **Frontend Architecture:** Modern, component-based Single-Page Application (SPA) built using **React.js** (HTML5, CSS3/Tailwind CSS, ES6+ JavaScript), integrated with **Axios** for asynchronous HTTP request handling.
* **Backend Architecture:** RESTful API services built using **Python / Flask**, enforcing the **Facade Structural Design Pattern** to streamline communication between client requests and underlying core modules.
* **Database Management System (DBMS):** Relational database powered by **PostgreSQL**, with object-relational mapping handled via **SQLAlchemy ORM** for data structure management, integrity, and scalability.
* **External API Integrations:** 
  * **Payment Processing:** Live payment gateway integration using **Moyasar / Tap API**.
  * **Location & Geolocation Services:** Integrated **Google Maps Platform API** (Geocoding & Distance Matrix) for seller/supplier mapping and dynamic delivery cost calculation.
* **Integration Strategy:** Complete decoupling of Frontend (React) and Backend (Flask) communicating exclusively through secure, JSON-formatted RESTful API contracts.

---

# 4. Out-of-Scope

The following features and services are explicitly excluded from the current MVP scope:

* 🎓 **Training Academy & Workshops:** Craft and business educational workshops or learning resources.
* 🤝 **Partner Directory:** Directory listings for third-party service providers (e.g., product photographers, branding designers, and specialized refrigerated logistics).
* 📱 **Native Mobile Applications:** Dedicated native iOS and Android mobile applications (the MVP will be strictly a responsive web application).
* 🚚 **Real-time Live GPS Tracking:** Dynamic, real-time driver/courier GPS tracking.
* 📊 **Advanced Predictive Analytics:** AI-based financial analytics, sales forecasting, or complex demand reporting.
* 🔄 **Automated ERP & Inventory Sync:** Direct automated inventory synchronization with suppliers' internal ERP systems.

*Note: The current MVP strictly focuses on establishing the core Mediator Platform model, the Smart Pricing Calculator, live payment gateway processing, and location/maps integration. The excluded features may be evaluated for future system releases.*

---

# 5. Project Risks

| Risk | Mitigation |
|---|---|
| Limited development time | Prioritize core MVP features and avoid unnecessary functionality. |
| Difficulty obtaining reliable supplier data | Use a controlled dataset for the MVP. |
| Limited experience with some technologies | Allocate early time for learning and prototyping. |
| Frontend/backend integration issues | Define APIs early and test integration regularly. |
| Large feature scope | Divide features into smaller tasks and prioritize essential functionality. |
| Team delays or blockers | Track tasks regularly and communicate blockers early. |

---

# 6. High-Level Project Plan

| Stage | Phase | Main Deliverable |
|---|---|---|
| **Stage 1** | Idea Development | Team formation and project idea selection |
| **Stage 2** | Project Charter | Objectives, stakeholders, scope, and risks |
| **Stage 3** | Technical Documentation | Requirements, architecture, database, and APIs |
| **Stage 4** | MVP Development | Functional Maksab web application |
| **Stage 5** | Project Closure | Testing, documentation, and final presentation |

## Project Flow

```text
Stage 1
Idea Development
       ↓
Stage 2
Project Charter
       ↓
Stage 3
Technical Documentation
       ↓
Stage 4
MVP Development
       ↓
Stage 5
Project Closure
```
# 7. Maksab's Unique Value

Maksab connects home-based businesses with wholesale suppliers in one
platform. Instead of selling products directly to customers, Maksab
helps entrepreneurs find the materials and supplies they need to
produce their products.

The platform helps users:

- Identify the materials and supplies needed for their products.
- Discover suitable wholesale suppliers.
- Compare available products and prices.
- Calculate the total production cost.
- Estimate a suitable selling price and profit margin.

### Core Workflow

```text
Product Idea
     ↓
Required Materials
     ↓
Find Suitable Suppliers
     ↓
Compare Products & Prices
     ↓
Calculate Production Cost
     ↓
Set Selling Price
```
# 8. Business Model

Maksab will generate revenue by connecting home-based businesses with
wholesale suppliers.

### Revenue Sources

- **Supplier Commission (After the MVP):** Maksab may receive a commission
  from suppliers for successful purchases after the MVP, when a purchase and
  payment process is available. Supplier commissions are not part of the MVP.

- **Premium Services:** In the future, business owners may pay for
  additional features and advanced tools.

- **Supplier Promotion:** Suppliers may pay for additional visibility
  and promotional placement on the platform.

The MVP will not generate revenue through supplier commissions because online
payments are out of scope. Supplier commissions, premium services, and supplier
promotion may be considered after the MVP.
