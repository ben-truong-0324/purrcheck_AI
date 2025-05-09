# System Patterns: Purr Check AI

**Project Name:** Purr Check AI

**Date:** May 8, 2025

**Author:** [Your Name/Team Name]

**Version:** 1.0

---

## 1. System Architecture (High-Level)

The system follows a typical web application architecture with a clear separation between the frontend, backend API, database, and external services.
+-------------+       +-------------+       +-------------------+       +-----------------+
|             |       |             |       |                   |       |                 |
|   Frontend  | <---> |  Backend API| <---> |  Database (SQL)   |       |   Stripe API    |
| (SPA - React/Vue) | | (Node.js/Python) |   | (PostgreSQL/MySQL)|       | (Payments)      |
|             |       |             |       |                   |       |                 |
+-------------+       +------+------+       +-------------------+       +--------+--------+
|                                                  |
|                                                  |
|           +-------------------------+            |
+---------> | AI Model API (LLM/Vision) | <--------+ (Webhook/Confirmation)
| (OpenAI/Google/Anthropic) |
+-------------------------+


* **Frontend:** A client-side Single Page Application (SPA) handles the user interface, photo uploads, text input, and displaying assessment results. It communicates with the Backend API via HTTP requests.
* **Backend API:** This acts as the central hub. It receives requests from the frontend, handles file uploads, validates input, interacts with the database, makes calls to the AI Model API, communicates with the Stripe API for payments, and sends responses back to the frontend.
* **Database:** A relational database stores information about users (eventually), pets, assessments, uploaded photos, and subscription statuses.
* **AI Model API:** An external service that provides the core AI capability to analyze pet photos and text input. The Backend API sends data to this service and receives structured assessment results.
* **Stripe API:** An external service handling payment processing, subscription management, and webhook notifications. The Backend API communicates with Stripe to initiate payments and confirm subscription statuses.

## 2. Key Technical Decisions (Initial Phase)

* **Frontend Framework:** [Chosen framework, e.g., React] - Provides a robust component model for building interactive UIs.
* **Backend Language/Framework:** [Chosen language/framework, e.g., Node.js with Express] - Provides a flexible environment for building APIs and handling asynchronous operations (critical for AI calls).
* **Database System:** [Chosen database, e.g., PostgreSQL] - A mature and reliable relational database suitable for structured data like user, pet, and assessment information.
* **AI Integration Strategy:** Using a third-party API allows for rapid development without the overhead of managing machine learning infrastructure.
* **Payment Gateway:** Stripe is chosen for its comprehensive API, developer-friendly documentation, and support for subscription billing.

## 3. Design Patterns in Use (or Planned)

* **Model-View-Controller (MVC) or similar pattern:** Applied in the backend to separate concerns (data handling, business logic, and API presentation).
* **API Gateway:** The Backend API acts as an API Gateway for the frontend, providing a single point of entry for various backend functionalities and abstracting interactions with external services.
* **Asynchronous Operations:** Handling potentially long-running tasks like AI processing asynchronously using background jobs or non-blocking I/O in the backend.
* **Webhook Handling:** Implementing webhook endpoints in the backend to receive notifications from Stripe about payment events (e.g., successful payment, subscription renewal).

## 4. Component Relationships

* Frontend depends on the Backend API for all data and operations.
* Backend API depends on the Database for persistence.
* Backend API depends on the AI Model API for performing assessments.
* Backend API depends on the Stripe API for payment processing.
* Stripe API communicates with the Backend API via webhooks to notify about payment status changes.

## 5. Critical Implementation Paths

* **Photo Upload to Assessment Display:** This is the core user flow and must be robust and reliable. It involves frontend upload, backend receiving and storing the photo temporarily, calling the AI API, receiving and processing results, storing the assessment, and displaying it to the user.
* **Free Assessment Limit Enforcement:** The logic to track free assessments and trigger the paywall must be correctly implemented.
* **Stripe Checkout and Subscription Activation:** The flow from hitting the paywall, initiating a Stripe checkout session, handling the redirect, and confirming the subscription status in the backend is critical for monetization.

## 6. Data Flow Example (Free Assessment)

1.  User uploads photo/text via Frontend.
2.  Frontend sends photo/text to Backend API `/assess`.
3.  Backend API receives data, saves photo temporarily, and creates a record for the assessment request in the database (initially maybe linked to session ID/IP).
4.  Backend API checks if the user/session has exceeded the free assessment limit.
5.  If limit not exceeded, Backend API calls the AI Model API with the photo and text.
6.  AI Model API processes data and returns assessment results to the Backend API.
7.  Backend API saves the full assessment results in the database, linked to the request record.
8.  Backend API sends the assessment results back to the Frontend.
9.  Frontend displays the assessment results to the user.

## 7. Data Flow Example (Paid Assessment - Purr Check Diary)

1.  User, who is a paid subscriber, uploads photo/text via Frontend.
2.  Frontend sends photo/text to Backend API `/assess`.
3.  Backend API receives data, authenticates the user (future feature), saves photo, and creates an assessment record linked to the user and their pet profile (future feature).
4.  Backend API checks if the user's subscription is active and within the weekly assessment limit.
5.  If active and within limit, Backend API calls the AI Model API.
6.  AI Model API processes data and returns assessment results.
7.  Backend API saves results in the database, linked to the user and pet profile.
8.  Backend API sends results back to the Frontend.
9.  Frontend displays assessment results.

---