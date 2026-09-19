AC_INIT([gnome-config], [1.0])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_PROG_AWK
AC_PROG_SED

default_least_non_favorite="gwin switch --index 1 --exclude \"chrome\|ghostty\|discord\""
default_action1_cmd="gwin raise com.mitchellh.ghostty.desktop"
default_action2_cmd="gwin raise google-chrome.desktop"
default_action3_cmd="gwin raise discord.desktop"
default_least_recent_application_window_cmd="gwin switch --index -1"
default_last_application_window_cmd="gwin switch --index 1 --exclude-focused-application"
default_last_application_instance_cmd="gwin switch --last-instance"
default_compose_key="ralt"

AC_ARG_WITH([preset],
    [AS_HELP_STRING([--with-preset=NAME], [Configuration preset: preset1, preset1-hq (default: preset1)])],
    [preset_choice="$withval"],
    [preset_choice="preset1"]
)

AS_CASE([$preset_choice],
    [preset1], [
        default_menu_cmd="rofi -show combi -combi-modes \"opwn,appl,urls,util\" -dpi 144 -x11 -normal-window"
    ],
    [preset1-hq], [
        default_menu_cmd="rofi -show combi -combi-modes \"opwn,appl,urls,util\" -dpi 256 -x11 -normal-window"
    ],
    [*], [
        AC_MSG_ERROR([Invalid preset '$preset_choice'])
    ]
)

AC_ARG_WITH([menu-cmd],
    [AS_HELP_STRING([--with-menu-cmd=COMMAND   dmenu command])],
    [MENU_CMD="$withval"], [MENU_CMD="$default_menu_cmd"]
)
MENU_CMD=$(printf '%s\n' "$MENU_CMD" | sed -e 's/"/\\\\"/g')
AC_SUBST([MENU_CMD])

AC_ARG_WITH([least-non-favorite-cmd],
    [AS_HELP_STRING([--with-least-non-favorite-cmd=COMMAND   command for raising the least non favorite window opened])],
    [LEAST_NON_FAVORITE_CMD="$withval"], [LEAST_NON_FAVORITE_CMD="$default_least_non_favorite"]
)
LEAST_NON_FAVORITE_CMD=$(printf '%s\n' "$LEAST_NON_FAVORITE_CMD" | sed -e 's/"/\\\\"/g')
AC_SUBST([LEAST_NON_FAVORITE_CMD])

AC_ARG_WITH([action1-cmd],
    [AS_HELP_STRING([--with-action1-cmd=COMMAND   super+1 key])],
    [ACTION1_CMD="$withval"], [ACTION1_CMD="$default_action1_cmd"]
)
ACTION1_CMD=$(printf '%s\n' "$ACTION1_CMD" | sed -e 's/"/\\\\"/g')
AC_SUBST([ACTION1_CMD])

AC_ARG_WITH([action2-cmd],
    [AS_HELP_STRING([--with-action2-cmd=COMMAND   super+2 key])],
    [ACTION2_CMD="$withval"], [ACTION2_CMD="$default_action2_cmd"]
)
ACTION2_CMD=$(printf '%s\n' "$ACTION2_CMD" | sed -e 's/"/\\\\"/g')
AC_SUBST([ACTION2_CMD])

AC_ARG_WITH([action3-cmd],
    [AS_HELP_STRING([--with-action3-cmd=COMMAND   super+3 key])],
    [ACTION3_CMD="$withval"], [ACTION3_CMD="$default_action3_cmd"]
)
ACTION3_CMD=$(printf '%s\n' "$ACTION3_CMD" | sed -e 's/"/\\\\"/g')
AC_SUBST([ACTION3_CMD])

AC_ARG_WITH([least-recent-application-window-cmd],
    [AS_HELP_STRING([--with-least-recent-application-window-cmd=COMMAND   command for raising the least recent application window])],
    [LEAST_RECENT_APPLICATION_WINDOW_CMD="$withval"], [LEAST_RECENT_APPLICATION_WINDOW_CMD="$default_least_recent_application_window_cmd"]
)
LEAST_RECENT_APPLICATION_WINDOW_CMD=$(printf '%s\n' "$LEAST_RECENT_APPLICATION_WINDOW_CMD" | sed -e 's/"/\\\\"/g')
AC_SUBST([LEAST_RECENT_APPLICATION_WINDOW_CMD])

AC_ARG_WITH([last-application-window-cmd],
    [AS_HELP_STRING([--with-last-application-window-cmd=COMMAND   command for raising the last opened application window])],
    [LAST_APPLICATION_WINDOW_CMD="$withval"], [LAST_APPLICATION_WINDOW_CMD="$default_last_application_window_cmd"]
)
LAST_APPLICATION_WINDOW_CMD=$(printf '%s\n' "$LAST_APPLICATION_WINDOW_CMD" | sed -e 's/"/\\\\"/g')
AC_SUBST([LAST_APPLICATION_WINDOW_CMD])

AC_ARG_WITH([last-application-instance-cmd],
    [AS_HELP_STRING([--with-last-application-instance-cmd=COMMAND   command for raising the last opened window of the current focused application])],
    [LAST_APPLICATION_INSTANCE_CMD="$withval"], [LAST_APPLICATION_INSTANCE_CMD="$default_last_application_instance_cmd"]
)
LAST_APPLICATION_INSTANCE_CMD=$(printf '%s\n' "$LAST_APPLICATION_INSTANCE_CMD" | sed -e 's/"/\\\\"/g')
AC_SUBST([LAST_APPLICATION_INSTANCE_CMD])

AC_ARG_WITH([compose-key],
    [AS_HELP_STRING([--with-compose-key=STRING   compose key])],
    [COMPOSE_KEY="$withval"], [COMPOSE_KEY="$default_compose_key"]
)
AC_SUBST([COMPOSE_KEY])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
