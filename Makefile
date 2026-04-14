MENU ?= rofi -show combi -combi-modes "opwn,appl,urls,util"
MENU_JOBS ?= rofi -show jobs
MENU_FLAGS ?= -dpi 144 -x11 -normal-window
SWITCH_TO_LATEST_NON_FAVORITE ?= gwin switch --last --exclude "chrome|ghostty|discord"

export MENU
export MENU_JOBS
export MENU_FLAGS
export SWITCH_TO_LATEST_NON_FAVORITE

TEMPLATES = $(wildcard dconf/*.template)
OUTPUT = settings.dconf

VARS_TO_ESCAPE = MENU MENU_JOBS MENU_FLAGS SWITCH_TO_LATEST_NON_FAVORITE

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
