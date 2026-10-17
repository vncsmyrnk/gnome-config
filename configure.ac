AC_INIT([gnome-config], [1.0])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_PATH_PROG([SHELLCHECK], [shellcheck])
AM_CONDITIONAL([HAVE_SHELLCHECK], [test -n "$SHELLCHECK"])

AC_PROG_AWK
AC_PROG_SED

default_menu_cmd="rofi -show combi -combi-modes \"drun,pass,totp,jobs,urls,util\" -x11 -normal-window"
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

AC_ARG_VAR([COMPOSE_KEY], [compose key])
AS_IF([test -z "$COMPOSE_KEY"], [
    COMPOSE_KEY="$default_compose_key"
])
AC_SUBST([COMPOSE_KEY])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
