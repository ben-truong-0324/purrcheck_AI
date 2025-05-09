# Project Brief: Purr Check AI

**Project Name:** Purr Check AI

**Date:** May 8, 2025

**Author:** Ben Truong

**Version:** 1.0

---

## 1. Project Overview

Purr Check AI is a micro SaaS application designed to provide pet owners with quick, AI-powered insights into their dog or cat's potential breed, age, and condition based on uploaded photos and optional text input. The initial offering is a web application, with future plans for native iOS and Android mobile apps. The service includes a free introductory assessment, followed by subscription tiers for ongoing access, historical data tracking, and multi-pet support, utilizing Stripe for payment processing.

## 2. Goals

* **Primary Goal:** Develop a functional web application that can receive pet photos and text input, process them using an LLM/vision model, and return a structured assessment to the user.
* **Secondary Goal:** Implement a freemium model allowing one free assessment per user.
* **Tertiary Goal:** Integrate Stripe for secure payment processing for subscription tiers.
* **Future Goal 1:** Develop and launch native iOS and Android mobile applications.
* **Future Goal 2:** Enhance AI capabilities for more accurate and detailed assessments.
* **Future Goal 3:** Implement features for tracking pet condition over time (Purr Check Diary, Pack Check Diary).

## 3. Scope

* **In Scope (Initial Phase):**
    * Simple landing page with photo upload and optional text input.
    * Backend endpoint to receive uploads and text.
    * Integration with an AI model for pet photo analysis and text processing.
    * Assessment display page showing breed, age, condition summary, and grooming recommendations.
    * Mechanism to track free assessment usage per user (e.g., via IP or simple user session initially).
    * Paywall redirect after the first free assessment.
    * Basic Stripe integration for handling subscriptions (initially focusing on the payment flow).
* **Out of Scope (Initial Phase):**
    * User accounts and authentication (basic tracking for free tier sufficient initially).
    * Full subscription management features within the app (initial focus is payment).
    * Mobile application development.
    * Historical assessment tracking and diary features.
    * Multi-pet profiles.
    * Advanced AI training or custom model development.
    * Complex user profiles or social features.

## 4. Target Audience

* Pet owners (primarily dog and cat owners) who are curious about their pet's characteristics or are seeking basic insights into their pet's potential health or grooming needs based on appearance.

## 5. Key Features

* Pet Photo Upload
* Optional Text Input
* AI-Powered Pet Assessment (Breed, Age, Condition Summary, Grooming Recommendations)
* One Free Assessment per User
* Stripe Payment Integration
* Subscription Tiers:
    * **Purr Check Diary:** Up to 5 assessments/week per pet profile, historical data tracking.
    * **Pack Check Diary:** Supports multiple pet profiles, up to 5 assessments/week per pet, historical data tracking.

## 6. Technology Stack (Proposed Initial)

* **Frontend:** React / Vue.js / Svelte (Single Page Application framework)
* **Backend:** Node.js (Express or NestJS) / Python (Flask or Django)
* **Database:** PostgreSQL / MySQL
* **AI Integration:** API calls to a third-party LLM/Vision Model (e.g., OpenAI Vision, Google Cloud Vision AI, Anthropic Claude with Vision)
* **Payment Processing:** Stripe API
* **Hosting:** Heroku / AWS / GCP / Azure

## 7. Success Metrics

* Number of free assessments completed.
* Conversion rate from free assessment to paid subscription.
* Number of active subscribers.
* User satisfaction with assessment accuracy and recommendations.

## 8. Risks & Mitigation

* **Risk:** AI model inaccuracy in assessment.
    * **Mitigation:** Clearly state the assessments are for informational purposes only and not a substitute for professional veterinary advice. Continuously evaluate and potentially switch or fine-tune AI models over time.
* **Risk:** Low conversion rate from free to paid.
    * **Mitigation:** Refine the value proposition of the paid tiers, gather user feedback on desired features, and optimize the paywall messaging.
* **Risk:** Technical complexity of integrating AI and payment systems.
    * **Mitigation:** Start with minimal viable integrations, use well-documented APIs (Stripe), and potentially use managed services for components like the database or hosting.
* **Risk:** Data privacy concerns with pet photos.
    * **Mitigation:** Implement robust data handling policies, encrypt sensitive data, and be transparent with users about how their data is used (solely for generating assessments).

## 9. Team & Resources

* Initial phase requires at least one full-stack developer with experience in the chosen tech stack and API integrations.
* Access to necessary cloud infrastructure and third-party API keys (AI, Stripe).

---