# AEP.dev Compliant TypeSpec API Design

A professional TypeSpec project that demonstrates enterprise-grade API designs compliant with [AEP (API Enhancement Proposal)](https://aep.dev/) standards. This reference implementation showcases best practices for building scalable, maintainable APIs using TypeSpec.

## 🎯 Project Overview

This project serves as a **production-ready reference implementation** for creating APIs that comply with the AEP system. It demonstrates how to use TypeSpec to design APIs that follow industry standards and enterprise best practices, making it an ideal starting point for teams adopting AEP standards.

## 🏗️ What We've Built

We've implemented a **comprehensive SaaS Accounts Management system** that demonstrates full AEP compliance:

- **Accounts**: Complete lifecycle management with filtering, pagination, and status tracking
- **Error Handling**: RFC 7807 Problem Details with proper HTTP content types
- **AEP Compliance**: All operations follow AEP naming conventions and parameter standards

**This is a work in progress** - we're building out a complete reference implementation of AEP-compliant APIs. See our [PROJECT_PLAN.md](./PROJECT_PLAN.md) for details on where we're headed next, including additional resources to demonstrate other AEP use cases.

## 📋 AEP Standards Implemented

This project implements the following AEP standards with enterprise-grade quality:

- **AEP-131**: Standard methods (list, get, create, apply, update, delete)
- **AEP-132**: List methods with proper pagination (`max_page_size`, `page_token`)
- **AEP-134**: Partial updates with PATCH operations
- **AEP-160**: Filtering with CEL expressions
- **AEP-122**: Resource paths
- **AEP-232-235**: Batch operations with proper URI patterns

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and pnpm
- Docker (for Swagger UI)

### Setup Steps

1. **Install Dependencies:**
   ```bash
   pnpm install
   ```

2. **Generate OpenAPI Specification:**
   ```bash
   pnpm run build
   ```

3. **Validate AEP Compliance:**
   ```bash
   pnpm run lint:aep
   ```

4. **Launch Interactive API Documentation:**
   ```bash
   docker run -p 8080:8080 -e SWAGGER_JSON=/openapi.yaml \
     -v $(pwd)/tsp-output/schema:/openapi swaggerapi/swagger-ui
   ```
   
   Access Swagger UI at: **http://localhost:8080**
