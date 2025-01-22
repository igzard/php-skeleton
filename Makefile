.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: composer-install
composer-install: ## install php packages
	php ./vendor/bin/composer install

.PHONY: phpunit
phpunit: ## Run phpunit
	php ./vendor/bin/phpunit --colors=always

.PHONY: cs-fix
cs-fix: ## Run php-cs-fixer
	php ./vendor/bin/php-cs-fixer fix --dry-run

.PHONY: cs-fix-check
cs-fix-check: ## Run php-cs-fixer-check
	php ./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.php --diff --dry-run --verbose

.PHONY: phpstan
phpstan: ## Run phpstan
	php ./vendor/bin/phpstan

.PHONY: rector
rector: ## Run phpstan
	php ./vendor/bin/rector --dry-run

.PHONY: test
test: cs-fix-check rector phpunit phpstan ## Run code quality tests