PROJECT = lanes
ROOT_DIR = $(shell pwd)
REPO = $(shell git config --get remote.origin.url)
LFE = _build/default/lib/lfe/bin/lfe
DOCS_DIR = $(ROOT_DIR)/docs
DOCS_BUILD_DIR = $(ROOT_DIR)/doc
LOCAL_DOCS_HOST = localhost
LOCAL_DOCS_PORT = 5099

compile:
	rebar3 compile

check:
	@DEBUG=1 rebar3 as test eunit

repl: compile
	@$(LFE)

shell:
	@rebar3 shell

clean:
	@rebar3 clean
	@rm -rf ebin/* _build/default/lib/$(PROJECT)

clean-all: clean
	@rebar3 as dev lfe clean

docs-clean:
	@echo "\nCleaning build directories ..."
	@rm -rf $(DOCS_BUILD_DIR)

docs: docs-clean
	@echo "\nBuilding docs ...\n"
	@cd $(DOCS_DIR) && mdbook build -d $(DOCS_BUILD_DIR)

docs-open: docs-clean
	@echo "\nBuilding docs ...\n"
	@cd $(DOCS_DIR) && mdbook build -d $(DOCS_BUILD_DIR) -o

publish: docs
	@echo "\nPublishing on hex.pm ...\n"
	@./priv/scripts/publish.sh

.PHONY: docs
