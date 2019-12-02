SHELL=/bin/zsh
today=`date +%F`
blog:
	@echo "Creating new entry for blog notes at blogs/$(today)"
	@touch blogs/$(today)
book:
	@echo "Creating new entry for book notes at book/$(today)"
	@touch books/$(today)
