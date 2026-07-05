MENU ?= rofi -show combi -combi-modes "opwn,appl,urls,util"
MENU_JOBS ?= rofi -show jobs
MENU_FLAGS ?= -dpi 144 -x11 -normal-window
SWITCH_TO_LATEST_NON_FAVORITE ?= gwin switch --index 1 --exclude "firefox\|ghostty\|discord"

export MENU
export MENU_JOBS
export MENU_FLAGS
export SWITCH_TO_LATEST_NON_FAVORITE

SRCDIR ?= .

TEMPLATES = $(shell find $(SRCDIR)/dconf -type f)
SETTINGS = $(SRCDIR)/settings.dconf

VARS_TO_ESCAPE = MENU MENU_JOBS MENU_FLAGS SWITCH_TO_LATEST_NON_FAVORITE

.PHONY: all install install-font install-extension-manager clean rebuild

all: $(SETTINGS)

$(SETTINGS): $(TEMPLATES)
	@for var_name in $(VARS_TO_ESCAPE); do \
		val="$${!var_name}"; \
		escaped=$$(echo "$$val" | sed 's/"/\\"/g'); \
		export "$$var_name=$$escaped"; \
	done; \
	cat $^ | envsubst | sed '/^#/d' > $@
	@echo "$@ generated."

.PHONY: install
install: all
	dconf load / < $(SETTINGS)

.PHONY: clean
clean:
	@rm -f $(SETTINGS)

.PHONY: install-font
install-font:
	@./bin/install-adwaita-font

.PHONY: install-extension-manager
install-extension-manager:
	@sudo pacman -S extension-manager

.PHONY: clear-extensions
clear-extensions:
	rm -r "$$HOME/.local/share/gnome-shell/extensions"
