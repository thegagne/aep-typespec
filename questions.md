# Open Questions & Decisions

This document tracks open questions, decisions to be made, and areas that need clarification as we implement the AEP.dev compliant TypeSpec project.

## Resource Design Questions

### 1. Product Resource Structure
- [ ] **Question**: Should we include product variants (different sizes, colors, etc.) as sub-resources or as a separate resource?
  - **AEP Impact**: Affects resource path structure (AEP-122)
  - **Options**: 
    - Sub-resource: `/products/{productId}/variants`
    - Separate resource: `/productVariants` with product reference
  - **Decision Needed**: Before implementing product models

### 2. Category Hierarchy Depth
- [ ] **Question**: What is the maximum depth for category hierarchies?
  - **AEP Impact**: Affects wildcard operations (AEP-122)
  - **Options**: 
    - Unlimited depth with recursion
    - Fixed maximum depth (e.g., 5 levels)
    - Dynamic depth based on business rules
  - **Decision Needed**: Before implementing category models

### 3. Inventory Resource Scope
- [ ] **Question**: Should inventory be a sub-resource of products or a separate resource?
  - **AEP Impact**: Affects resource path structure and batch operations
  - **Options**:
    - Sub-resource: `/products/{productId}/inventory`
    - Separate resource: `/inventory` with product reference
    - Hybrid approach with both
  - **Decision Needed**: Before implementing inventory models

## AEP Compliance Questions

### 4. Error Code Standardization
- [ ] **Question**: Which specific error codes should we implement beyond the basic HTTP status codes?
  - **AEP Impact**: Error handling consistency
  - **Options**:
    - Google Cloud API error codes
    - Custom business-specific error codes
    - AEP standard error code set
  - **Decision Needed**: Before implementing error models

### 5. Pagination Implementation
- [ ] **Question**: Should we support both cursor-based and offset-based pagination?
  - **AEP Impact**: AEP-131 compliance
  - **Options**:
    - Cursor-based only (recommended by AEP)
    - Offset-based only
    - Both with preference for cursor-based
  - **Decision Needed**: Before implementing pagination models

### 6. Batch Operation Transactional Support
- [ ] **Question**: For which batch operations should we require transactional support?
  - **AEP Impact**: AEP-232-235 compliance
  - **Options**:
    - All batch operations require transactional
    - Only critical operations (delete, update)
    - Optional for all operations
  - **Decision Needed**: Before implementing batch operations

## Technical Implementation Questions

### 7. TypeSpec Version
- [ ] **Question**: Which TypeSpec version should we target for production?
  - **Impact**: Feature availability and stability
  - **Options**:
    - Latest stable version
    - LTS version if available
    - Specific version for compatibility
  - **Decision Needed**: Before setting up project configuration

### 8. OpenAPI Emitter Configuration
- [ ] **Question**: Should we generate both OpenAPI 3.0 and 3.1 specifications?
  - **Impact**: Tool compatibility and AEP compliance
  - **Options**:
    - OpenAPI 3.0 only (more widely supported)
    - OpenAPI 3.1 only (latest standard)
    - Both versions
  - **Decision Needed**: Before configuring TypeSpec compiler

### 9. Validation and Linting
- [ ] **Question**: What validation rules should we implement for AEP compliance?
  - **Impact**: Code quality and compliance checking
  - **Options**:
    - Custom TypeSpec linting rules
    - OpenAPI validation tools
    - AEP-specific compliance checkers
  - **Decision Needed**: Before implementing validation pipeline

## Business Logic Questions

### 10. Product Lifecycle States
- [ ] **Question**: What are the valid product lifecycle states and transitions?
  - **Impact**: State management patterns
  - **Options**:
    - Draft → Active → Discontinued
    - Draft → Active → Inactive → Discontinued
    - Custom business-specific states
  - **Decision Needed**: Before implementing product models

### 11. Order Status Workflow
- [ ] **Question**: What is the complete order status workflow?
  - **Impact**: State machine implementation
  - **Options**:
    - Simple: Pending → Confirmed → Shipped → Delivered
    - Complex: Multiple intermediate states and rollback options
    - Custom business workflow
  - **Decision Needed**: Before implementing order models

### 12. Customer Privacy Requirements
- [ ] **Question**: What privacy and data protection requirements should we model?
  - **Impact**: Customer resource design
  - **Options**:
    - Basic GDPR compliance
    - Full privacy framework
    - No specific privacy requirements
  - **Decision Needed**: Before implementing customer models

## Documentation Questions

### 13. Example Complexity
- [ ] **Question**: How complex should our examples be to demonstrate AEP patterns?
  - **Impact**: Documentation clarity and usefulness
  - **Options**:
    - Simple examples for clarity
    - Complex real-world scenarios
    - Both simple and complex examples
  - **Decision Needed**: Before creating examples

### 14. AEP Pattern Documentation
- [ ] **Question**: Should we create separate documentation for each AEP pattern implemented?
  - **Impact**: Documentation organization
  - **Options**:
    - Single comprehensive guide
    - Pattern-specific documentation
    - Hybrid approach with overview and details
  - **Decision Needed**: Before planning documentation structure

## External Dependencies

### 15. AEP Specification Updates
- [ ] **Question**: How should we handle updates to AEP specifications during development?
  - **Impact**: Project timeline and compliance
  - **Options**:
    - Freeze AEP versions for project duration
    - Adapt to updates as they occur
    - Plan for version migration
  - **Decision Needed**: Before starting implementation

### 16. Tool Integration
- [ ] **Question**: Which tools should we integrate for AEP compliance validation?
  - **Impact**: Development workflow and quality assurance
  - **Options**:
    - OpenAPI validation tools
    - Custom AEP compliance checkers
    - Manual review process
  - **Decision Needed**: Before setting up validation pipeline

## Decision Tracking

### Decisions Made
- [x] **Resource Selection**: Products & Inventory Management system
- [x] **Project Structure**: TypeSpec-based implementation
- [x] **AEP Standards**: Focus on AEP-131, AEP-122, AEP-232-235

### Pending Decisions
- [ ] Product resource structure (Question 1)
- [ ] Category hierarchy depth (Question 2)
- [ ] Inventory resource scope (Question 3)
- [ ] Error code standardization (Question 4)
- [ ] Pagination implementation (Question 5)
- [ ] Batch operation transactional support (Question 6)

### Next Review Points
- **Week 1**: Review resource design questions (1-3)
- **Week 2**: Review AEP compliance questions (4-6)
- **Week 3**: Review technical implementation questions (7-9)
- **Week 4**: Review business logic questions (10-12)
- **Week 5**: Review documentation questions (13-14)
- **Week 6**: Review external dependency questions (15-16)

## Action Items

- [ ] Schedule review meetings for each question category
- [ ] Research AEP specifications for specific guidance
- [ ] Consult with stakeholders for business logic decisions
- [ ] Evaluate tool options for technical implementation
- [ ] Create decision matrix for complex questions
- [ ] Document rationale for all decisions made
