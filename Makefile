SHELL =/bin/zsh
today = `date +%F`
name =

blog:
	@echo "Creating new entry for blog notes at blogs/$(today).md"
	@touch blogs/$(today).md
	@ln -sFi blogs/$(today).md tb
book:
ifeq ($(name),)
	@echo "What's the name of the book?"
else
	@$(eval SLUGIFIED=$(shell echo "$(name)" | iconv -t ascii//TRANSLIT | sed -E 's/[~\^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+//g' | tr A-Z a-z))
	@echo "Creating new entry for book notes at book/${SLUGIFIED}.md"
	@touch books/$(SLUGIFIED).md
endif
