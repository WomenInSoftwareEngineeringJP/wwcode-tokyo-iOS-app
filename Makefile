.PHONY: ios server

ios:
	@cd ios && make bootstrap

server:
	@cd server && make test
