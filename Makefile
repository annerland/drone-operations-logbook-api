.PHONY: up down test build migrate seed cmd

DC := docker compose
APP := $(DC) exec -T app

up:
	$(DC) up -d

down:
	$(DC) down

build:
	$(APP) composer install --no-interaction
	$(APP) php artisan migrate:fresh --seed --force

cmd:
	$(DC) exec -it app bash

migrate:
	$(APP) php artisan migrate --force

seed:
	$(APP) php artisan db:seed --force

test:
	$(APP) composer cs-fix
	$(APP) composer phpstan
	$(APP) php artisan test
