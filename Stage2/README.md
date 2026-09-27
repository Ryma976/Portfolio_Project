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

- **Smart Pricing:** By the end of Stage 4 (MVP Development), users can enter
  material, packaging, and labor costs and correctly receive the production
  cost, a suggested selling price, and the profit margin.

- **Wholesale Sourcing:** By the end of Stage 4 (MVP Development), users can
  browse supplier products, search and filter them, add items to a cart,
  complete a payment through a payment gateway in test mode, and view supplier
  and productive-family locations on a map.

- **Business Support:** By the end of Stage 4 (MVP Development), users can
  browse craft and business workshops, view workshop details, submit an
  interest form, and browse a partner directory with contact information.

---

# 2. Stakeholders and Team Roles

## Stakeholders

| Stakeholder | Type | Role |
|---|---|---|
| Project Team (4 members) | Internal | Project roles and responsibilities |
| Instructor / Tutor | Internal | Guidance and evaluation |
| Home-Based Businesses | External | Primary target users |
| Suppliers | External | Provide raw materials and packaging products |
| Training / Service Providers | External | Provide workshops and business-support services |

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

The MVP will include four main modules:

### 🧮 Smart Pricing Calculator

- Material cost input.
- Packaging cost input.
- Labor/time cost input.
- Production cost calculation.
- Suggested selling price.
- Profit margin calculation.

### 📦 Wholesale Marketplace

- Raw-material and packaging suppliers.
- Wholesale product catalog.
- Product search and filtering.
- Shopping cart.
- Estimated total cost.
- Payment gateway integration in test mode (e.g., Tap or Moyasar).
- Map view of supplier and productive-family locations using a Maps API.

### 🎓 Training Academy

- Craft and business workshops.
- Workshop details.
- Basic registration interest form.

### 🤝 Partner Directory

- Product photographers.
- Branding and visual-identity designers.
- Refrigerated delivery providers.
- Contact information for service providers.

## 3.2 Technical Scope

- Responsive web application.
- React.js.
- Python.
- Flask.
- Facade design pattern.
- Relational database (PostgreSQL or MySQL).
- SQLAlchemy ORM.
- Payment gateway integration in test mode.
- Google Maps API.
- Frontend and backend integration.

---

# 4. Out-of-Scope

The following features are excluded from the current MVP:

- Live (real-money) payment processing.
- Live logistics and real-time GPS tracking.
- Advanced financial and sales analytics.
- VIP or paid subscription tiers.
- Native iOS and Android applications.

These features may be considered for future releases.

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
