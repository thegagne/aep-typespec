import "@typespec/http";
import "@typespec/openapi";
import "../lib/errors.tsp";

using Http;

namespace SAAS;

const examplePath = "accounts/acc_123";
const exampleAccountId = "acme-corp";
const exampleAccountName = "Acme Corporation";
const exampleAccountDescription = "A leading technology company";
const exampleAccountCreateTime = "2024-01-15T00:00:00Z";
const exampleAccountUpdateTime = "2024-01-15T00:00:00Z";
const exampleNextPageToken = "eyJwYWdlIjoyLCJza2lwIjoyNTB9";
const exampleTotalSize = 1250;
const exampleUpdatedAccountName = "Updated Acme Corp";
const exampleUpdatedAccountDescription = "Updated company description";
const exampleUpdatedAccountUpdateTime = "2024-01-16T10:00:00Z";
const examplePatchAccountDescription = "Updated company description with new details";
const examplePatchAccountUpdateTime = "2024-01-16T11:00:00Z";

const exampleDeleteResponse = #{
  statusCode: 204,
  body: #{}
};

const exampleAccount = #{
    path: examplePath,
    id: exampleAccountId,
    name: exampleAccountName,
    description: exampleAccountDescription,
    status: AccountStatus.ACTIVE,
    plan: AccountPlan.STARTER,
    create_time: exampleAccountCreateTime,
    update_time: exampleAccountUpdateTime
};

// Base resource model with common fields
// Following AEP-122 resource path representation
@doc("Base resource model with common fields")
@summary("Common resource properties")
model BaseResource {
  // Resource path following AEP-122 pattern
  // Format: {resourceType}s/{resourceId}
  @doc("The resource path string")
  @example("accounts/acc_123")
  @visibility(Lifecycle.Read)
  path: string;
}

// Account model - represents an organization
@doc("An account represents an organization or tenant")
@summary("Account entity")
@OpenAPI.extension("x-aep-resource", #{
  singular: "account",
  plural: "accounts",
  patterns: #[
    "accounts",
    "accounts/{account_id}"
  ]
})
model Account extends BaseResource {
  @doc("Unique account identifier")
  @example(exampleAccountId)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  id: string;

  @doc("Account name")
  @example(exampleAccountName)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  name: string;

  @doc("Account description")
  @example(exampleAccountDescription)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  description?: string;

  @doc("Account status")
  @example(AccountStatus.ACTIVE)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  status: AccountStatus;

  @doc("Account plan/tier")
  @example(AccountPlan.STARTER)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  plan: AccountPlan;

  @doc("When the account was created")
  @example(exampleAccountCreateTime)
  @visibility(Lifecycle.Read)
  create_time: string;

  @doc("When the account was last updated")
  @example(exampleAccountUpdateTime)
  @visibility(Lifecycle.Read)
  update_time: string;
}


@doc("Account model for create operations - excludes read-only fields")
@summary("Create account response")
@OpenAPI.extension("x-aep-resource", #{
    singular: "account",
    plural: "accounts",
    patterns: #[
      "accounts",
      "accounts/{account_id}"
    ]
  })
model CreateAccount is Create<Account>;


@doc("Account model for update operations - excludes read-only fields")
@summary("Update account response")
@OpenAPI.extension("x-aep-resource", #{
    singular: "account",
    plural: "accounts",
    patterns: #[
      "accounts",
      "accounts/{account_id}"
    ]
  })
model UpdateAccount is Update<Account>;
model DeleteAccount {};
model DeleteAccountResponse {
    ...Http.NoContentResponse,
    ...Body<DeleteAccount>
}

// Account status enumeration
@doc("Account status enumeration")
@summary("Available account statuses")
enum AccountStatus {
  @doc("Account is active and operational")
  @summary("Active")
  ACTIVE,

  @doc("Account is suspended")
  @summary("Suspended")
  SUSPENDED,

  @doc("Account is inactive")
  @summary("Inactive")
  INACTIVE,

  @doc("Account is pending activation")
  @summary("Pending")
  PENDING
}

// Account plan enumeration
@doc("Account plan enumeration")
@summary("Available account plans")
enum AccountPlan {
  @doc("Starter plan with basic features")
  @summary("Starter")
  STARTER,

  @doc("Professional plan with advanced features")
  @summary("Professional")
  PROFESSIONAL,

  @doc("Enterprise plan with full features")
  @summary("Enterprise")
  ENTERPRISE
}

// List accounts response
@doc("Response containing a list of accounts with pagination")
@summary("List accounts response")
@OpenAPI.extension("x-aep-resource", #{
  singular: "account",
  plural: "accounts",
  patterns: #[
    "accounts/{account_id}"
  ]
})
model ListAccountsResponse {
  @doc("List of accounts (AEP-132 compliant)")
  @example(#[exampleAccount])
  results: Account[];

  @doc("Token for the next page of results, empty if no more results (AEP-132 compliant)")
  @example(exampleNextPageToken)
  next_page_token?: string;

  @doc("Total count of resources matching the criteria (AEP-132 compliant)")
  @example(exampleTotalSize)
  total_size?: int64;
}

// Account service interface
@route("/accounts")
@tag("Accounts")
interface AccountService {
  @doc("List accounts with optional filtering and pagination")
  @summary("List accounts")
  @OpenAPI.operationId("ListAccounts")
  @opExample(#{
    parameters: #{
      filter: "status == ACTIVE",
      max_page_size: 100,
      page_token: exampleNextPageToken
    },
    returnType: #{
       results: #[exampleAccount],
       next_page_token: exampleNextPageToken,
       total_size: exampleTotalSize
    }
  }, #{
    title: "List accounts",
    description: "List accounts filtered by status == ACTIVE"
  })
  @get list(
    @query filter?: string,
    @query order_by?: string,
    @query max_page_size?: integer,
    @query page_token?: string
  ): ListAccountsResponse | ValidationProblem | NotFoundProblem;

  @doc("Get an account by ID")
  @summary("Get account")
  @OpenAPI.operationId("GetAccount")
  @opExample(#{
    parameters: #{
      account_id: exampleAccountId
    },
    returnType: exampleAccount
  }, #{
    title: "Get account by ID",
    description: "Retrieve an existing account using its unique identifier"
  })
  @get get(
    @path account_id: string
  ): Account | NotFoundProblem;

  @doc("Create a new account")
  @summary("Create account")
  @OpenAPI.operationId("CreateAccount")
  @opExample(#{
    parameters: #{
      id: exampleAccountId,
      request: #{
        id: exampleAccountId,
        name: exampleAccountName,
        description: exampleAccountDescription,
        status: AccountStatus.ACTIVE,
        plan: AccountPlan.STARTER
      }
    },
    returnType: #{
      path: examplePath,
      id: exampleAccountId,
      name: exampleAccountName,
      description: exampleAccountDescription,
      status: AccountStatus.ACTIVE,
      plan: AccountPlan.STARTER,
      create_time: exampleAccountCreateTime,
      update_time: exampleAccountUpdateTime
    }
  }, #{
    title: "Create new account",
    description: "Create a new account with starter plan and active status"
  })
  @post create(
    @query id?: string,
    @body request: CreateAccount
  ): Account | ValidationProblem | ConflictProblem;

  @doc("Apply an account, whether it exists or not")
  @summary("Apply account")
  @OpenAPI.operationId("ApplyAccount")
  @opExample(#{
    parameters: #{
      account_id: exampleAccountId,
      request: #{
        id: exampleAccountId,
        name: exampleUpdatedAccountName,
        description: exampleUpdatedAccountDescription,
        status: AccountStatus.ACTIVE,
        plan: AccountPlan.ENTERPRISE
      }
    },
    returnType: #{
      path: examplePath,
      id: exampleAccountId,
      name: exampleUpdatedAccountName,
      description: exampleUpdatedAccountDescription,
      status: AccountStatus.ACTIVE,
      plan: AccountPlan.ENTERPRISE,
      create_time: exampleAccountCreateTime,
      update_time: exampleUpdatedAccountUpdateTime
    }
  }, #{
    title: "Apply account changes",
    description: "Update existing account or create new one if it doesn't exist"
  })
  @put apply(
    @path account_id: string,
    @body request: CreateAccount
  ): Account | ValidationProblem | NotFoundProblem;

  @doc("Update specific account fields (description or plan only)")
  @summary("Update account")
  @OpenAPI.operationId("UpdateAccount")
  @opExample(#{
    parameters: #{
      account_id: exampleAccountId,
      request: #{
        name: exampleAccountName,
        status: AccountStatus.ACTIVE,
        description: examplePatchAccountDescription,
        plan: AccountPlan.ENTERPRISE
      },
      contentType: "application/merge-patch+json"
    },
    returnType: #{
      path: examplePath,
      id: exampleAccountId,
      name: exampleAccountName,
      description: examplePatchAccountDescription,
      status: AccountStatus.ACTIVE,
      plan: AccountPlan.ENTERPRISE,
      create_time: exampleAccountCreateTime,
      update_time: examplePatchAccountUpdateTime
    }
  }, #{
    title: "Partial update account",
    description: "Update specific account fields using PATCH operation"
  })
  @patch
  @route("/{account_id}")
  patch(
    @path account_id: string,
    @body request: UpdateAccount,
    @header contentType: "application/merge-patch+json"
  ): Account | ValidationProblem | NotFoundProblem;

  @doc("Delete an account")
  @summary("Delete account")
  @OpenAPI.operationId("DeleteAccount")
  @opExample(#{
    parameters: #{
      account_id: exampleAccountId
    },
    returnType: exampleDeleteResponse
  }, #{
    title: "Delete account",
    description: "Remove an account from the system"
  })
  @delete delete(
    @path account_id: string
  ): DeleteAccountResponse | NotFoundProblem;
}
