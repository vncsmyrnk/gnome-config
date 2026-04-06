ROFI_FLAGS ?= -dpi 144 -x11 -show combi -combi-modes "opwn,urls,util,appl" -normal-window
GWIN_EXCLUDED_APPLICATIONS ?= chrome|ghostty|discord

export ROFI_FLAGS
export GWIN_EXCLUDED_APPLICATIONS

TEMPLATES = $(wildcard dconf/*.template)
OUTPUT = settings.dconf

.PHONY: all install install-font install-extension-manager clean rebuild

all: install

$(OUTPUT): $(TEMPLATES)
	@echo "Generating $@ from templates directory..."
	@ESCAPED_ROFI_FLAGS=$$(echo '$(ROFI_FLAGS)' | sed 's/"/\\"/g') ; \
		export ROFI_FLAGS="$$ESCAPED_ROFI_FLAGS"; \
		cat $^ | envsubst | sed '/^#/d' > $@

install: $(OUTPUT)
	@echo "Applying to dconf..."
	@dconf load / < $(OUTPUT)

install-font:
	@./bin/install-adwaita-font

install-extension-manager:
	@sudo pacman -S extension-manager

clean:
	@rm -f $(OUTPUT)

clear-extensions:
	rm -r "$$HOME/.local/share/gnome-shell/extensions"

rebuild: clean install
