# Database Structure: Purr Check AI

**Project Name:** Purr Check AI

**Date:** May 8, 2025

**Author:** Ben Truong

**Version:** 1.0

---

## 1. Stack

* **Database System:** PostgreSQL
* **ORM/Database Driver:** [e.g., Sequelize, TypeORM, or Node-Postgres (`pg`)]

## 2. Database Schema (Proposed)

Here is a proposed schema structure. Fields marked with `[Nullable]` can be null. Fields marked with `[Future]` are planned for later phases but included for foresight.

**Table: `users` [Future]**

* **Purpose:** Stores user account information once authentication is implemented.
* **Relationships:** One-to-many with `pets`, one-to-many with `subscriptions`.
* **Fields:**
    * `id` (UUID or Integer, Primary Key) - Unique identifier for the user.
    * `email` (VARCHAR, Unique) - User's email address.
    * `password_hash` (VARCHAR) - Hashed password for login.
    * `created_at` (TIMESTAMP) - Timestamp when the user was created.
    * `updated_at` (TIMESTAMP) - Timestamp when the user was last updated.

**Table: `pets` [Future]**

* **Purpose:** Stores information about each pet associated with a user for the Diary features.
* **Relationships:** Many-to-one with `users`, one-to-many with `assessments`.
* **Fields:**
    * `id` (UUID or Integer, Primary Key) - Unique identifier for the pet.
    * `user_id` (UUID or Integer, Foreign Key to `users.id`) - The user who owns this pet.
    * `name` (VARCHAR) - The pet's name.
    * `species` (ENUM or VARCHAR - 'dog', 'cat') - The species of the pet.
    * `breed` (VARCHAR) - Known breed (can be user-provided or initial AI guess).
    * `date_of_birth` (DATE) [Nullable] - The pet's known date of birth.
    * `created_at` (TIMESTAMP) - Timestamp when the pet profile was created.
    * `updated_at` (TIMESTAMP) - Timestamp when the pet profile was last updated.

**Table: `assessments`**

* **Purpose:** Stores the results of each AI assessment.
* **Relationships:** Many-to-one with `users` [Future], Many-to-one with `pets` [Future], One-to-one with `photos`.
* **Fields:**
    * `id` (UUID or Integer, Primary Key) - Unique identifier for the assessment.
    * `user_id` (UUID or Integer, Foreign Key to `users.id`) [Nullable] - The user who requested the assessment (null for initial free assessments without accounts).
    * `pet_id` (UUID or Integer, Foreign Key to `pets.id`) [Nullable] - The pet this assessment is for (null for initial free assessments).
    * `photo_id` (UUID or Integer, Foreign Key to `photos.id`, Unique) - The photo used for this assessment.
    * `input_text` (TEXT) [Nullable] - The optional text input provided by the user.
    * `ai_breed_guess` (VARCHAR) [Nullable] - The AI's estimated breed(s).
    * `ai_age_guess` (VARCHAR) [Nullable] - The AI's estimated age or age range.
    * `ai_condition_summary` (TEXT) [Nullable] - The AI's summary of the pet's apparent condition based on the photo.
    * `ai_grooming_recommendations` (TEXT) [Nullable] - The AI's recommended grooming services and frequency.
    * `is_free_assessment` (BOOLEAN, Default: TRUE) - Flag indicating if this was the user's free assessment.
    * `created_at` (TIMESTAMP) - Timestamp when the assessment was recorded.

**Table: `photos`**

* **Purpose:** Stores metadata about the uploaded photos. The actual photo file will be stored in cloud storage (e.g., S3, GCS).
* **Relationships:** One-to-one with `assessments`.
* **Fields:**
    * `id` (UUID or Integer, Primary Key) - Unique identifier for the photo.
    * `file_path` (VARCHAR) - The path or key to the photo file in cloud storage.
    * `file_name` (VARCHAR) - The original name of the uploaded file.
    * `mime_type` (VARCHAR) - The MIME type of the file.
    * `uploaded_at` (TIMESTAMP) - Timestamp when the photo was uploaded.

**Table: `subscriptions` [Future]**

* **Purpose:** Stores information about user subscriptions managed by Stripe.
* **Relationships:** Many-to-one with `users`.
* **Fields:**
    * `id` (UUID or Integer, Primary Key) - Unique identifier for the subscription record.
    * `user_id` (UUID or Integer, Foreign Key to `users.id`) - The user with this subscription.
    * `stripe_customer_id` (VARCHAR, Unique) - The customer ID in Stripe.
    * `stripe_subscription_id` (VARCHAR, Unique) - The subscription ID in Stripe.
    * `plan_name` (VARCHAR) - The name of the subscription plan (e.g., 'Purr Check Diary', 'Pack Check Diary').
    * `status` (ENUM or VARCHAR - 'active', 'canceled', 'past_due', etc.) - The current status of the subscription (synced from Stripe).
    * `current_period_start` (TIMESTAMP) - The start of the current billing period.
    * `current_period_end` (TIMESTAMP) - The end of the current billing period.
    * `canceled_at` (TIMESTAMP) [Nullable] - Timestamp if the subscription was canceled.
    * `created_at` (TIMESTAMP) - Timestamp when the subscription record was created.
    * `updated_at` (TIMESTAMP) - Timestamp when the subscription record was last updated (e.g., status change).

**Table: `payment_events` [Future]**

* **Purpose:** Logs events received from Stripe webhooks for auditing and debugging.
* **Fields:**
    * `id` (UUID or Integer, Primary Key) - Unique identifier for the event log.
    * `stripe_event_id` (VARCHAR, Unique) - The unique ID of the event from Stripe.
    * `event_type` (VARCHAR) - The type of the Stripe event (e.g., `checkout.session.completed`, `customer.subscription.updated`).
    * `payload` (JSONB) - The full JSON payload received from Stripe.
    * `processed` (BOOLEAN, Default: FALSE) - Flag indicating if the event has been processed by our system.
    * `created_at` (TIMESTAMP) - Timestamp when the event was received.

## 3. Relationships and Logic

* A `user` can have multiple `pets` and multiple `subscriptions` (though likely only one active subscription at a time).
* A `pet` belongs to one `user` and can have multiple `assessments` over time.
* An `assessment` is linked to the `photo` used for that assessment. It can optionally be linked to a `user` (for free tier tracking initially, then for paid users) and a `pet` (for diary features).
* The `is_free_assessment` flag in the `assessments` table is used in the initial phase to track the single free assessment per user (potentially linked via IP or session ID before full user accounts).
* The `subscriptions` table is primarily populated and updated based on incoming Stripe webhooks. The `status`, `current_period_start`, and `current_period_end` fields are crucial for determining active subscription status and assessment limits.
* The `payment_events` table provides a log of all Stripe events received, which is vital for debugging payment processing issues.

## 4. Notes

* The schema is designed to be extended in future phases to support user accounts, multiple pets, and historical tracking.
* Using UUIDs for primary keys provides better scalability than sequential integers, especially in a distributed environment, though integers are also viable initially.
* Storing photos externally in cloud storage and only keeping the file path in the database is standard practice for handling binary data efficiently.
* JSONB is a good choice for storing the raw Stripe webhook payload as it allows for flexible querying of the event data.
* Implementing database migrations is crucial for managing schema changes as the project evolves.

---