provider "tfe" {
  hostname = var.hostname
}

data "tfe_agent_pool" "aws" {
  name         = var.agent_pool_name
  organization = var.org
}

# resource "tfe_organization_membership" "developers" {
#   organization = var.org
#   email        = "assareh+developer@hashicorp.com"
# }

# resource "tfe_team_organization_member" "developer" {
#   team_id                    = tfe_team.developers.id
#   organization_membership_id = tfe_organization_membership.developers.id
# }

# resource "tfe_team" "developers" {
#   name         = "${var.use_case_name}-developers"
#   organization = var.org
# }

# resource "tfe_organization_membership" "ops" {
#   organization = var.org
#   email        = "assareh+operator@hashicorp.com"
# }

# resource "tfe_team_organization_member" "operator" {
#   team_id                    = tfe_team.ops.id
#   organization_membership_id = tfe_organization_membership.ops.id
# }

# resource "tfe_team" "ops" {
#   name         = "${var.use_case_name}-ops"
#   organization = var.org
# }

# resource "tfe_team_access" "development-dev" {
#   access       = "admin"
#   team_id      = tfe_team.developers.id
#   workspace_id = tfe_workspace.development.id
# }

# resource "tfe_team_access" "staging-dev" {
#   access       = "write"
#   team_id      = tfe_team.developers.id
#   workspace_id = tfe_workspace.staging.id
# }

# resource "tfe_team_access" "production-dev" {
#   access       = "read"
#   team_id      = tfe_team.developers.id
#   workspace_id = tfe_workspace.production.id
# }

# resource "tfe_team_access" "production-ops" {
#   access       = "admin"
#   team_id      = tfe_team.ops.id
#   workspace_id = tfe_workspace.production.id
# }

# resource "tfe_team_access" "staging-ops" {
#   access       = "admin"
#   team_id      = tfe_team.ops.id
#   workspace_id = tfe_workspace.staging.id
# }

# resource "tfe_team_access" "development-ops" {
#   access       = "admin"
#   team_id      = tfe_team.ops.id
#   workspace_id = tfe_workspace.development.id
# }

resource "tfe_workspace" "development" {
  name              = "${var.use_case_name}-development"
  organization      = var.org
  auto_apply        = true
  queue_all_runs    = false
  terraform_version = "1.1.2"
  tag_names         = [var.use_case_name]
  execution_mode    = "agent"
  agent_pool_id     = data.tfe_agent_pool.aws.id

  # vcs_repo {
  #   branch         = "development"
  #   identifier     = var.vcs_identifier
  #   oauth_token_id = var.oauth_token
  # }
}

resource "tfe_workspace" "staging" {
  name              = "${var.use_case_name}-staging"
  organization      = var.org
  auto_apply        = true
  terraform_version = "1.1.2"
  tag_names         = [var.use_case_name]
  execution_mode    = "agent"
  agent_pool_id     = data.tfe_agent_pool.aws.id

  # vcs_repo {
  #   branch         = "staging"
  #   identifier     = var.vcs_identifier
  #   oauth_token_id = var.oauth_token
  # }
}

resource "tfe_workspace" "production" {
  name              = "${var.use_case_name}-production"
  organization      = var.org
  terraform_version = "1.1.2"
  tag_names         = [var.use_case_name]
  execution_mode    = "agent"
  agent_pool_id     = data.tfe_agent_pool.aws.id

  # vcs_repo {
  #   branch         = "main"
  #   identifier     = var.vcs_identifier
  #   oauth_token_id = var.oauth_token
  # }
}

resource "tfe_variable" "workspace_var_staging" {
  key      = "control_workspace_workspace"
  value    = local.my_workspace_env
  category = "terraform"

  workspace_id = tfe_workspace.staging.id
}

resource "tfe_variable" "workspace_var_development" {
  key      = "control_workspace_workspace"
  value    = local.my_workspace_env
  category = "terraform"

  workspace_id = tfe_workspace.development.id
}

resource "tfe_variable" "workspace_var_production" {
  key      = "control_workspace_workspace"
  value    = local.my_workspace_env
  category = "terraform"

  workspace_id = tfe_workspace.production.id
}

resource "tfe_variable" "org_var_production" {
  key          = "control_workspace_organization"
  value        = var.org
  category     = "terraform"
  workspace_id = tfe_workspace.production.id
}

resource "tfe_variable" "org_var_development" {
  key          = "control_workspace_organization"
  value        = var.org
  category     = "terraform"
  workspace_id = tfe_workspace.development.id
}

resource "tfe_variable" "org_var_staging" {
  key          = "control_workspace_organization"
  value        = var.org
  category     = "terraform"
  workspace_id = tfe_workspace.staging.id
}

resource "tfe_variable" "set_ttl1" {
  key          = "WORKSPACE_TTL"
  value        = "30"
  category     = "env"
  workspace_id = tfe_workspace.development.id
}

resource "tfe_variable" "set_ttl2" {
  key          = "WORKSPACE_TTL"
  value        = "30"
  category     = "env"
  workspace_id = tfe_workspace.staging.id
}

resource "tfe_variable" "set_ttl3" {
  key          = "WORKSPACE_TTL"
  value        = "30"
  category     = "env"
  workspace_id = tfe_workspace.production.id
}

resource "tfe_variable" "environment_name_dev" {
  key          = "environment"
  value        = "dev"
  category     = "env"
  workspace_id = tfe_workspace.development.id
}

resource "tfe_variable" "environment_name_stage" {
  key          = "environment"
  value        = "stage"
  category     = "env"
  workspace_id = tfe_workspace.staging.id
}

resource "tfe_variable" "environment_name_prod" {
  key          = "environment"
  value        = "prod"
  category     = "env"
  workspace_id = tfe_workspace.production.id
}

resource "tfe_variable" "name_dev" {
  key          = "name"
  value        = var.use_case_name
  category     = "env"
  workspace_id = tfe_workspace.development.id
}

resource "tfe_variable" "name_staging" {
  key          = "name"
  value        = var.use_case_name
  category     = "env"
  workspace_id = tfe_workspace.staging.id
}

resource "tfe_variable" "name_prod" {
  key          = "name"
  value        = var.use_case_name
  category     = "env"
  workspace_id = tfe_workspace.production.id
}

data "tfe_team" "github-actions" {
  name         = "github-actions"
  organization = var.org
}

resource "tfe_team_access" "development-github" {
  access       = "write"
  team_id      = data.tfe_team.github-actions.id
  workspace_id = tfe_workspace.development.id
}

resource "tfe_team_access" "staging-github" {
  access       = "write"
  team_id      = data.tfe_team.github-actions.id
  workspace_id = tfe_workspace.staging.id
}

resource "tfe_team_access" "production-github" {
  access       = "write"
  team_id      = data.tfe_team.github-actions.id
  workspace_id = tfe_workspace.production.id
}

resource "tfe_variable" "tfe_token_dev" {
  key          = "TFE_TOKEN"
  value        = tfe_team_token.app.token
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.development.id
}

resource "tfe_variable" "tfe_token_stage" {
  key          = "TFE_TOKEN"
  value        = tfe_team_token.app.token
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.staging.id
}

resource "tfe_variable" "tfe_token_prod" {
  key          = "TFE_TOKEN"
  value        = tfe_team_token.app.token
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.production.id
}

resource "tfe_team" "app" {
  name         = var.use_case_name
  organization = var.org
}

resource "tfe_team_token" "app" {
  team_id = tfe_team.app.id
}

resource "tfe_team_access" "app-control" {
  team_id      = tfe_team.app.id
  workspace_id = tfe_workspace.development.id

  permissions {
    runs              = "read"
    run_tasks         = false
    sentinel_mocks    = "none"
    state_versions    = "read-outputs"
    variables         = "none"
    workspace_locking = false
  }
}
