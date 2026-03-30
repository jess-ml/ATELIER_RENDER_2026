terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 1.7.0"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

variable "github_actor" {
  description = "GitHub username"
  type        = string
}

resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.image_tag
    }
  }

  env_vars = {
    ENV = {
      value = "production"
    }
    # On ajoute l'URL de la base de données générée par Render
    DATABASE_URL = {
      value = render_postgres.db.connection_info.internal_connection_string
    }
  }

# Création de la base de données PostgreSQL
resource "render_postgres" "db" {
  name          = "my-database-${var.github_actor}"
  plan          = "free"
  region        = "frankfurt"
  version       = "15" 
  database_name = "flask_db"
}
