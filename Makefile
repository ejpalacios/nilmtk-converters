.PHONY: isort black mypy test local-ci clean

PACKAGE := nilmtk_converters

## Create virtual environment
.venv/bin/activate: pyproject.toml
	poetry install

## Export requirements file
requirements.txt: pyproject.toml
	poetry export -o requirements.txt -f requirements.txt --without-hashes --without dev --without test

isort: .venv/bin/activate
	poetry run isort $(PACKAGE) $(TEST) --check-only

black: .venv/bin/activate
	poetry run black $(PACKAGE) $(TEST) --check

mypy: .venv/bin/activate
	poetry run mypy $(PACKAGE) $(TEST) --install-types --non-interactive

## Run local CI
local-ci: isort black mypy

## Clean files
clean:
	rm -rf .mypy_cache
	rm -rf .pytest_cache
	rm -rf .venv

