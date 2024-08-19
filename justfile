# List available commands
default:
    just --list --unsorted --list-heading $'Available commands\n'

# Run dev server
run-dev: install-modules
    #!/bin/zsh

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
