AC_INIT([gnome-config], [1.0])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_PATH_PROG([SHELLCHECK], [shellcheck])
AM_CONDITIONAL([HAVE_SHELLCHECK], [test -n "$SHELLCHECK"])

AC_PROG_AWK
AC_PROG_SED

default_menu_cmd="rofi -show combi -combi-modes \"opwn,appl,pass,totp,jobs,urls,util\" -x11 -normal-window"
default_least_non_favorite_cmd="gwin switch --index 1 --exclude \"chrome\|ghostty\|discord\""
default_action1_cmd="gwin raise com.mitchellh.ghostty.desktop"
default_action2_cmd="gwin raise google-chrome.desktop"
default_action3_cmd="gwin raise discord.desktop"
default_least_recent_application_window_cmd="gwin switch --index -1"
default_last_application_window_cmd="gwin switch --index 1 --exclude-focused-application"
default_last_application_instance_cmd="gwin switch --last-instance"
default_compose_key="menu"

sanitize_cmd() {
  printf '%s\n' "$1" | sed \
    -e 's/"/\\\\"/g' \
    -e "s/'/'\\\\''/g"
}

AC_ARG_VAR([PRESET], [Configuration preset: preset1, preset1-hq (default: preset1)])
AS_IF([test -z "$PRESET"], [
    PRESET="preset1"
])

AS_CASE(["$PRESET"],
    [preset1], [
        default_menu_cmd+=" -dpi 144"
    ],
    [preset1-hq], [
        default_menu_cmd+=" -dpi 256"
    ],
    [*], [
        AC_MSG_ERROR([Invalid preset '$PRESET'])
    ]
)

AC_ARG_VAR([MENU_CMD], [dmenu command])
AS_IF([test -z "$MENU_CMD"], [
    MENU_CMD="$default_menu_cmd"
])
MENU_CMD=$(sanitize_cmd "$MENU_CMD")
AC_SUBST([MENU_CMD])

AC_ARG_VAR([LEAST_NON_FAVORITE_CMD], [command for raising the least non favorite window opened])
AS_IF([test -z "$LEAST_NON_FAVORITE_CMD"], [
    LEAST_NON_FAVORITE_CMD="$default_least_non_favorite_cmd"
])
LEAST_NON_FAVORITE_CMD=$(sanitize_cmd "$LEAST_NON_FAVORITE_CMD")
AC_SUBST([LEAST_NON_FAVORITE_CMD])

AC_ARG_VAR([ACTION1_CMD], [super+1 key])
AS_IF([test -z "$ACTION1_CMD"], [
    ACTION1_CMD="$default_action1_cmd"
])
ACTION1_CMD=$(sanitize_cmd "$ACTION1_CMD")
AC_SUBST([ACTION1_CMD])

AC_ARG_VAR([ACTION2_CMD], [super+2 key])
AS_IF([test -z "$ACTION2_CMD"], [
    ACTION2_CMD="$default_action2_cmd"
])
ACTION2_CMD=$(sanitize_cmd "$ACTION2_CMD")
AC_SUBST([ACTION2_CMD])

AC_ARG_VAR([ACTION3_CMD], [super+3 key])
AS_IF([test -z "$ACTION3_CMD"], [
    ACTION3_CMD="$default_action3_cmd"
])
ACTION3_CMD=$(sanitize_cmd "$ACTION3_CMD")
AC_SUBST([ACTION3_CMD])

AC_ARG_VAR([LEAST_RECENT_APPLICATION_WINDOW_CMD], [command for raising the least recent application window])
AS_IF([test -z "$LEAST_RECENT_APPLICATION_WINDOW_CMD"], [
    LEAST_RECENT_APPLICATION_WINDOW_CMD="$default_least_recent_application_window_cmd"
])
LEAST_RECENT_APPLICATION_WINDOW_CMD=$(sanitize_cmd "$LEAST_RECENT_APPLICATION_WINDOW_CMD")
AC_SUBST([LEAST_RECENT_APPLICATION_WINDOW_CMD])

AC_ARG_VAR([LAST_APPLICATION_WINDOW_CMD], [command for raising the last opened application window])
AS_IF([test -z "$LAST_APPLICATION_WINDOW_CMD"], [
    LAST_APPLICATION_WINDOW_CMD="$default_last_application_window_cmd"
])
LAST_APPLICATION_WINDOW_CMD=$(sanitize_cmd "$LAST_APPLICATION_WINDOW_CMD")
AC_SUBST([LAST_APPLICATION_WINDOW_CMD])

AC_ARG_VAR([LAST_APPLICATION_INSTANCE_CMD], [command for raising the last opened window of the current focused application])
AS_IF([test -z "$LAST_APPLICATION_INSTANCE_CMD"], [
    LAST_APPLICATION_INSTANCE_CMD="$default_last_application_instance_cmd"
])
LAST_APPLICATION_INSTANCE_CMD=$(sanitize_cmd "$LAST_APPLICATION_INSTANCE_CMD")
AC_SUBST([LAST_APPLICATION_INSTANCE_CMD])

AC_ARG_VAR([COMPOSE_KEY], [compose key])
AS_IF([test -z "$COMPOSE_KEY"], [
    COMPOSE_KEY="$default_compose_key"
])
AC_SUBST([COMPOSE_KEY])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
