MENU ?= rofi -dpi 144 -x11 -show combi -combi-modes "opwn,appl,urls,util" -normal-window
SWITCH_TO_LATEST_NON_FAVORITE ?= gwin switch --last --exclude "chrome|ghostty|discord"

export MENU
export SWITCH_TO_LATEST_NON_FAVORITE

TEMPLATES = $(wildcard dconf/*.template)
OUTPUT = settings.dconf

VARS_TO_ESCAPE = MENU SWITCH_TO_LATEST_NON_FAVORITE

.PHONY: all install install-font install-extension-manager clean rebuild

all: install

$(OUTPUT): $(TEMPLATES)
	@echo "Generating $@ from templates directory..."
	@for var_name in $(VARS_TO_ESCAPE); do \
		val="$${!var_name}"; \
		escaped=$$(echo "$$val" | sed 's/"/\\"/g'); \
		export "$$var_name=$$escaped"; \
	done; \
		cat $^ | envsubst | sed '/^#/d' > $@

install: $(OUTPUT)
	@echo "Applying to dconf..."
	@dconf load / < $(OUTPUT)
	@echo "Done."

install-font:
	@./bin/install-adwaita-font

install-extension-manager:
	@sudo pacman -S extension-manager

clean:
	@rm -f $(OUTPUT)

clear-extensions:
	rm -r "$$HOME/.local/share/gnome-shell/extensions"

rebuild: clean install
