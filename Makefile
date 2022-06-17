.PHONY: install-vscode-ext
install-vscode-ext:
	for f in `cat oneshot/vscode_list_extensions.txt`; do code --install-extension $$f; done