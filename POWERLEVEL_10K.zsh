# To customize prompt, run `p10k configure` or edit this file.

# Load Powerlevel10k theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# Prompt appearance settings
typeset -g POWERLEVEL9K_MODE=nerdfont-complete
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)

# Prompt segment settings
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}┌─%f"
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}└╴%f"
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIVIS_FOREGROUND=green
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIVIS_FOREGROUND=red
typeset -g POWERLEVEL9K_PROMPT_CHAR='\u276f'
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_START_SYMBOL=''

# Directory segment
typeset -g POWERLEVEL9K_DIR_FOREGROUND=blue
typeset -g POWERLEVEL9K_DIR_SHORTEN_STRATEGY="truncate_to_last"
typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=""
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=40
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=cyan

# Git segment
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=green
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=yellow
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=red

# Exit status
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=green
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=red

# Command execution time
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=magenta

# Time segment
typeset -g POWERLEVEL9K_TIME_FOREGROUND=cyan
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'

# Enable icons (make sure you have a Nerd Font)
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true




