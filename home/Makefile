.PHONY: help
#: ヘルプコマンド
help:
	@grep -A1 -E "^#:" Makefile \
	| grep -v -- -- \
	| sed 'N;s/\n/###/' \
	| sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
	| column -t  -s '###'

.PHONY: prod-task
prod-task:
	$(eval TASK_ID := $(shell aws ecs list-tasks --cluster prod-sugi-admin --query 'taskArns[0]' | tr -d '"' | cut -d "/" -f3))

.PHONY: stg-task
stg-task:
	$(eval TASK_ID := $(shell aws ecs list-tasks --cluster stg-sugi-admin --query 'taskArns[0]' | tr -d '"' | cut -d "/" -f3))

.PHONY: stg-db
#: スギstg db
stg-db: stg-task
	-aws ecs execute-command --cluster stg-sugi-admin --task $(TASK_ID) --interactive --container rails --command "bin/rails db"

.PHONY: prod-console
#: スギprod console
prod-console: prod-task
	-aws ecs execute-command --cluster prod-sugi-admin --task $(TASK_ID) --interactive --container rails --command "bin/rails c"

.PHONY: docker-bash
# exitすると make: *** [docker-bash] Error 130 がでるので無視するために-をつけてる
#: コンテナにbashで入る
docker-bash: docker-select-container-id
	-docker exec -it $(CONTAINER_ID) bash

.PHONY: docker-attach
# exitすると make: *** [docker-bash] Error 130 がでるので無視するために-をつけてる
#: コンテナで実行中のコマンドにattach
docker-attach: docker-select-container-id
	-docker attach $(CONTAINER_ID)

.PHONY: docker-logs
#: コンテナのログを見る
docker-logs: docker-select-container-id
	@docker container logs $(CONTAINER_ID) --tail 500

.PHONY: docker-select-container-id
docker-select-container-id:
	$(eval CONTAINER_ID := $(shell docker ps --format "{{.Names}} {{.ID}}" |  peco  | awk '{print $$2}'))
