.PHONY: dummy_translations extract_translations help pull_translations push_translations

.DEFAULT_GOAL := help

WORKDIR := freetextresponse

help: ## display this help message
	@echo "Please use \`make <target>' where <target> is one of"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'


## Localization targets

extract_translations: ## extract strings to be translated, outputting .po files
	# Extract Python and Django template strings
	mkdir -p $(WORKDIR)/translations/en/LC_MESSAGES/
	rm -f $(WORKDIR)/translations/en/LC_MESSAGES/{django-partial,django,text}.{po,mo}
	cd $(WORKDIR) && i18n_tool extract
	cat $(WORKDIR)/translations/en/LC_MESSAGES/django-partial.po | \
		grep -v 'Plural-Forms: nplurals' > $(WORKDIR)/translations/en/LC_MESSAGES/text.po
	rm -f $(WORKDIR)/translations/en/LC_MESSAGES/django-partial.po

compile_translations: ## compile translation files, outputting .mo files for each supported language
	cd $(WORKDIR) && i18n_tool generate

detect_changed_source_translations: ## Determines if the source translation files are up-to-date, otherwise exit with a non-zero code.
	cd $(WORKDIR) && i18n_tool changed

pull_translations: ## pull translations from Transifex
	cd $(WORKDIR) && i18n_tool transifex pull
	make compile_translations

push_translations: extract_translations ## push source translation files (.po) to Transifex
	tx push -s

dummy_translations: ## generate dummy translation (.po) files
	cd $(WORKDIR) && i18n_tool dummy

build_dummy_translations: extract_translations dummy_translations compile_translations ## generate and compile dummy translation files

validate_translations: build_dummy_translations detect_changed_source_translations ## validate translations

requirments:  ## Install development requirements
	pip install .
	pip install -r requirements-dev.txt
