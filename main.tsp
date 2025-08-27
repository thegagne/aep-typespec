// Main TypeSpec file for AEP.dev compliant API design
// This file serves as the entry point and defines the main API service

import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

// Import our AEP-compliant resources
import "./resources/accounts.tsp";

using Http;

// Main API service following AEP standards
@OpenAPI.info(#{
  contact: #{
    name: "John Doe",
    email: "john.doe@example.com",
    url: "https://example.com",
  },
  summary: "API for managing accounts in a SaaS application",
})
@OpenAPI.tagMetadata("Accounts", #{ description: "Accounts" })
@doc("Example SaaS API")
@service(#{ title: "Example SaaS API" })
@server("https://api.example.com", "Production API server")
namespace SAAS;
