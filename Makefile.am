DCONF_PARTS = \
	dconf/defaults.conf.in \
	dconf/interface.conf.in \
	dconf/keybindings.conf.in \
	dconf/power.conf.in \
	dconf/shell.conf.in

EXTRA_DIST = dconf

GENERATED_FILE = settings.dconf
CLEANFILES = $(GENERATED_FILE)

pkgdata_DATA = $(GENERATED_FILE)

$(GENERATED_FILE): $(DCONF_PARTS)
	@echo "Concatenating dconf parts..."
	cat $(DCONF_PARTS) | sed \
		-e '/^#/d' \
		-e 's|@MENU_CMD[@]|$(MENU_CMD)|g' \
		-e 's|@LEAST_NON_FAVORITE_CMD[@]|$(LEAST_NON_FAVORITE_CMD)|g' \
		-e 's|@ACTION1_CMD[@]|$(ACTION1_CMD)|g' \
		-e 's|@ACTION2_CMD[@]|$(ACTION2_CMD)|g' \
		-e 's|@ACTION3_CMD[@]|$(ACTION3_CMD)|g' \
		-e 's|@LEAST_RECENT_APPLICATION_WINDOW_CMD[@]|$(LEAST_RECENT_APPLICATION_WINDOW_CMD)|g' \
		-e 's|@LAST_APPLICATION_WINDOW_CMD[@]|$(LAST_APPLICATION_WINDOW_CMD)|g' \
		-e 's|@LAST_APPLICATION_INSTANCE_CMD[@]|$(LAST_APPLICATION_INSTANCE_CMD)|g' \
		-e 's|@COMPOSE_KEY[@]|$(COMPOSE_KEY)|g' \
		> $@

install-data-hook:
	@echo "To apply these settings to your user account, run (WITHOUT sudo):"
	@echo "dconf load / < $(pkgdatadir)/$(GENERATED_FILE)"
