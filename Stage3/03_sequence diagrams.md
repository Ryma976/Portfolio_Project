# 3. High-Level Sequence Diagrams

## Purpose

The sequence diagrams below show how the main components of Maksab (Frontend, Backend, Database, and external services) interact during key MVP use cases.

---

## 3.1 Checkout and Payment Flow

```mermaid
sequenceDiagram
    actor Merchant
    participant Frontend
    participant Backend
    participant Maps as Google Maps
    participant Database
    participant Moyasar

    Merchant->>Frontend: Pin delivery location on map
    Frontend->>Maps: Load interactive map & get coordinates
    Maps-->>Frontend: Return pin coordinates

    Merchant->>Frontend: Click "Pay Now"
    Frontend->>Backend: POST /api/checkouts (Location + Items)
    Backend->>Backend: Validate coordinates within Riyadh boundary
    Backend->>Database: Save Checkout & Order (Status: Pending)
    Database-->>Backend: Return Checkout ID
    Backend-->>Frontend: Return Checkout Summary

    Merchant->>Frontend: Enter Card Details
    Frontend->>Moyasar: Send card details directly for tokenization
    Moyasar-->>Frontend: Return Payment Token
    Frontend->>Backend: POST /api/payments (Token + Checkout ID)
    Backend->>Moyasar: Create Payment Session
    Moyasar-->>Backend: Return Bank Verification Redirect URL
    Backend-->>Frontend: Redirect to Bank Page

    Merchant->>Moyasar: Complete 3D Secure Bank Verification
    Moyasar-->>Backend: Send Webhook Callback (Payment Event)
    Backend->>Moyasar: Fetch Payment directly to verify status & amount

    alt Payment Confirmed
        Backend->>Database: Update Checkout & Orders status to "Paid"
        Backend->>Database: Clear Active Cart
        Backend-->>Frontend: 200 OK (Payment Confirmed)
        Frontend-->>Merchant: Show Order Confirmation Page
    else Payment Failed
        Backend->>Database: Update Payment status to "Failed"
        Backend-->>Frontend: Payment Failed Error
        Frontend-->>Merchant: Show Failure Message (Cart Retained)
    end

```
# 3.2 Pricing Calculator Flow
```mermaid
sequenceDiagram
    actor Merchant
    participant Frontend
    participant Backend

    Merchant->>Frontend: Enter material, packaging, labor costs & margin
    Frontend->>Backend: POST /api/calculator/price
    
    alt Inputs Valid
        Backend->>Backend: Calculate unit production cost
        Backend->>Backend: Calculate suggested price & net profit
        Backend-->>Frontend: Return calculated values
        Frontend-->>Merchant: Display unit cost, suggested price & profit
    else Invalid Inputs
        Backend-->>Frontend: 400 Bad Request (Validation Error)
        Frontend-->>Merchant: Display clear validation error message
    end
```
