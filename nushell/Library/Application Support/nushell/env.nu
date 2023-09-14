# Nushell Environment Config File

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIR = ($nu.config-path | path dirname | path join 'lib')

let-env NU_LIB_DIRS = [
    $env.NU_LIB_DIR
]

let-env DEFAULT_CONFIG_FILE = (
  $env.NU_LIB_DIR
  | path join "default_config.nu"
)

let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
}

# Starship set up
let-env STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = ": "
let-env PROMPT_INDICATOR_VI_NORMAL = "〉"
let-env PROMPT_MULTILINE_INDICATOR = "::: "

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'lib')
]

# Directories to search for plugin binaries when calling register
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

####################################
############ HOMEBREW ##############
####################################
let-env PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')


####################################
############## CARGO ###############
####################################
let-env PATH = ($env.PATH | prepend ([$env.HOME '.cargo/bin'] | path join))

# FNM
# load env variables
fnm env --json | from json | load-env

# add dynamic fnm path
let-env PATH = ($env.PATH | append [$"($env.FNM_MULTISHELL_PATH)/bin"])
# FNM END #

# Adding homebrew bison to PATH
let-env PATH = ($env.PATH | prepend '/opt/homebrew/opt/bison/bin')

# Adding Bazel to path
let-env PATH = ($env.PATH | prepend '/opt/homebrew/opt/bazel/bin')

# Flutter 
let-env PATH = ($env.PATH | prepend ([$env.HOME 'development/flutter/bin'] | path join))


####################################
############## PYENV ###############
####################################
def-env pyenv [command, ...args] {
    let pyenv = if $command in ["activate", "deactivate", "rehash", "shell"] {
        if $command == "shell" {
            { PYENV_VERSION_OLD: $env.PYENV_VERSION PYENV_VERSION: $args.0 }
        }
    } else {
        ^pyenv $command $args
        {}
    }
    load-env $pyenv
}

