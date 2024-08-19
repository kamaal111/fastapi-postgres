set export

DATABASE_NAME := "fast_api_postgres_db"
DATABASE_USER := "fast-api-postgres-user"
LOCAL_DATABASE_PASSWORD := "secure-password"
DATABASE_PORT := "5432"
DATABASE_HOST := "db"

# List available commands
default:
    just --list --unsorted --list-heading $'Available commands\n'

# Run dev server
run-dev: install-modules
    #!/bin/zsh

    export DATABASE_URL="postgresql://$DATABASE_USER:$LOCAL_DATABASE_PASSWORD@$DATABASE_HOST:$DATABASE_PORT/$DATABASE_NAME?sslmode=disable"
    export RUN_MODE="DEBUG"

    . .venv/bin/activate
    fastapi dev src/fastapi_postgres/main.py

# Set up dev container. This step runs after building the dev container
post-dev-container-create:
    just .devcontainer/post-create
    just bootstrap

# Bootstrap project
bootstrap: install-modules

[private]
install-modules:
    #!/bin/zsh

    . "$HOME/.rye/env"

    rye sync

[private]
setup-pre-commit:
    #!/bin/zsh

    . .venv/bin/activate
    pre-commit install
