# Tech Stack Comparison: Isar + Riverpod vs. Hive + Provider

This document outlines the rationale for selecting Isar and Riverpod for the Charity (Digital Sanctuary) app, prioritizing offline-first capabilities, scalability, and maintainability.

## 1. Local Database: Isar vs. Hive

### Why Isar?
*   **Query Capabilities:** Isar offers powerful query filters (composite indexes, full-text search) which are critical for features like searching the Bible, filtering Devotions by topic, or querying Missions data. Hive requires loading all data into memory to filter, which is inefficient for large datasets like a Bible.
*   **ACID Compliance:** Isar is fully ACID (Atomicity, Consistency, Isolation, Durability) compliant, ensuring data integrity during offline syncs and complex transactions.
*   **Type Safety:** Isar works directly with Dart objects and generates type-safe query code.
*   **Performance:** Isar is extremely fast (written in Rust) and optimized for mobile devices, often outperforming Hive in read/write operations.
*   **Future Proofing:** Isar is the spiritual successor to Hive (created by the same author) and is designed to overcome Hive's architectural limitations.

### Why not Hive?
*   **Limited Querying:** Hive is a key-value store. Complex queries are slow and memory-intensive.
*   **Type Safety Issues:** Hive stores data as `dynamic` or requires manual TypeAdapters which can be error-prone.
*   **Maintenance:** Isar is the more modern and actively developed solution for complex data needs.

## 2. State Management: Riverpod vs. Provider

### Why Riverpod?
*   **Compile-time Safety:** Riverpod catches provider errors at compile-time (e.g., `ProviderNotFoundException` is impossible).
*   **No Context Dependency:** Riverpod providers can be accessed without a `BuildContext`, making it easier to separate business logic from UI code (clean architecture).
*   **Testability:** Overriding providers for testing is built-in and straightforward.
*   **Flexibility:** Modifiers like `.family` (pass parameters) and `.autoDispose` (memory management) are powerful tools for dynamic UIs.

### Why not Provider?
*   **Runtime Exceptions:** Dependent on the widget tree; if a provider is not found in the context hierarchy, it crashes at runtime.
*   **Boilerplate:** often requires more boilerplate code for complex dependency injection.
*   **Widget Tree Coupling:** Tightly couples state with the widget tree, making non-UI logic harder to manage cleanly.

## Conclusion
For an offline-first app that requires:
1.  **Complex Data Handling** (Bible search, Missions filtering).
2.  **Robust Syncing** (ACID transactions).
3.  **Scalable Architecture** (Clean separation of concerns).

**Isar + Riverpod** is the superior choice over Hive + Provider.
