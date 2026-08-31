# Default port if not provided via command line
PORT ?= 8087

.PHONY: help preview render check clean publish

help: ## Show this help
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile \
		| sed 's/:.*##/:/' \
		| awk -F':' '{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Variables:"
	@printf "  \033[36m%-10s\033[0m %s\n" "PORT" "preview port (default $(PORT))"
	@echo ""

preview: ## Start quarto preview (override with PORT=xxxx)
	@echo "Starting Quarto preview on port $(PORT)..."
	quarto preview . --no-browser --port $(PORT)

render: ## Render the Quarto website into _site
	@echo "Rendering Quarto website..."
	quarto render

check: ## Run quarto check to verify environment and configuration
	@echo "Running quarto check..."
	quarto check

clean: ## Remove build artifacts (_site and .quarto)
	@echo "Cleaning up Quarto site..."
	rm -rf _site .quarto

publish: ## Publish to the gh-pages branch by hand (CI normally does this)
	@echo "Publishing to gh-pages..."
	quarto publish gh-pages
