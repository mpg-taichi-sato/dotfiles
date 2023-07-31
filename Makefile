.PHONY: build-oneshot
#: build-oneshot
build-oneshot:
	code --list-extensions > oneshot/vscode_list_extensions.txt

.PHONY: install-vscode-insiders-ext
install-vscode-insiders-ext:
	for f in `cat oneshot/vscode_list_extensions.txt`; do code-insiders --install-extension $$f; done

.PHONY: install-vscode-ext
install-vscode-ext:
	for f in `cat oneshot/vscode_list_extensions.txt`; do code --install-extension $$f; done