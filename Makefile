SSH_PUB = $(shell cat $(HOME)/.ssh/id_rsa.pub)

build:
		docker build -t controller --build-arg ssh_pub_key="$(SSH_PUB)" --squash .
run:
		@docker run --mount type=bind,source="$(CURDIR)"/switch,target=/root/switch -id -p 2222:22 controller
clean_key:
		@sed -i '' '/\[localhost\]:2222/d' ~/.ssh/known_hosts
ssh:
		ssh -A root@localhost -p 2222
