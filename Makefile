#======================================#
# GNU Make Options                     #
#======================================#

MAKEFLAGS += --warn-undefined-variables --no-builtin-rules
SHELL := bash
.SHELLFLAGS := -euo pipefail -c

.DELETE_ON_ERROR:
ONESHELL:


#======================================#
# Testing Across Ruby Versions         #
#======================================#

SUPPORTED_RUBY_VERSIONS := 2.7  3.0  3.1  3.2
DOCKER_TAG_PREFIX := uuid-next-lib:ruby-

test-all: $(foreach version,$(SUPPORTED_RUBY_VERSIONS),test-$(version))
	@echo
	@echo All tests have passed for all Ruby versions.

test-%:
	@echo "Testing debian based Ruby $*..."
	@docker build --build-arg "RUBY_VERSION=$*" -t "$(DOCKER_TAG_PREFIX)$*" .
	@docker run --rm -t -v $(PWD):/proj -w /proj $(DOCKER_TAG_PREFIX)$*
	@echo "Testing alpine based Ruby $*..."
	@docker build --build-arg "RUBY_VERSION=$*" -t "$(DOCKER_TAG_PREFIX)$*-alpine" -f Dockerfile.alpine .
	@docker run --rm -t -v $(PWD):/proj -w /proj $(DOCKER_TAG_PREFIX)$*-alpine
