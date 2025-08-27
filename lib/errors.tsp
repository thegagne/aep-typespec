// Problem Details for HTTP APIs (RFC 7807) error models
// This file contains shared error models that follow the RFC 7807 standard

import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";

// Base Problem Details model following RFC 7807 standard
@error
@doc("Base Problem Details model following RFC 7807 standard")
@summary("Standard error response format")
model ProblemDetails {
  
  // A URI reference that identifies the problem type
  @doc("A URI reference that identifies the problem type")
  @example("https://api.example.com/errors/invalid-argument")
  type: string;
  
  // A short, human-readable summary of the problem type
  @doc("A short, human-readable summary of the problem type")
  @example("Invalid Argument")
  title: string;
  
  // The HTTP status code for this occurrence of the problem
  @doc("The HTTP status code for this occurrence of the problem")
  @example(400)
  status: integer;
  
  // A human-readable explanation specific to this occurrence of the problem
  @doc("A human-readable explanation specific to this occurrence of the problem")
  @example("The request contains invalid arguments")
  detail?: string;
  
  // A URI reference that identifies the specific occurrence of the problem
  @doc("A URI reference that identifies the specific occurrence of the problem")
  @example("/products/123")
  instance?: string;
}

// Validation Problem response model
@doc("Validation error response with proper content type")
model ValidationProblem {
  @Http.header contentType: "application/problem+json";
  @Http.statusCode _: 400;
  @example(#{
    type: "https://api.example.com/errors/validation-error",
    title: "Validation Error",
    status: 400,
    detail: "The request contains invalid arguments: ...",
    instance: "..."
  })
  @Http.body validationError: ProblemDetails;
}

// Not Found Problem response model
@doc("Not found error response with proper content type")
model NotFoundProblem {
  @Http.header contentType: "application/problem+json";
  @Http.statusCode _: 404;
  @example(#{
    type: "https://api.example.com/errors/not-found",
    title: "Not Found",
    status: 404,
    detail: "The requested resource was not found",
    instance: "..."
  })
  @Http.body notFoundError: ProblemDetails;
}

// Conflict Problem response model
@doc("Conflict error response with proper content type")
model ConflictProblem {
  @Http.header contentType: "application/problem+json";
  @Http.statusCode _: 409;
  @example(#{
    type: "https://api.example.com/errors/conflict",
    title: "Conflict",
    status: 409,
    detail: "The request conflicts with the current state of the resource",
    instance: "..."
  })
  @Http.body conflictError: ProblemDetails;
}

// Invalid Argument Problem response model
@doc("Invalid argument error response with proper content type")
model InvalidArgumentProblem {
  @Http.header contentType: "application/problem+json";
  @Http.statusCode _: 400;
  @example(#{
    type: "https://api.example.com/errors/invalid-argument",
    title: "Invalid Argument",
    status: 400,
    detail: "One or more arguments are invalid",
    instance: "..."
  })
  @Http.body invalidArgumentError: ProblemDetails;
}