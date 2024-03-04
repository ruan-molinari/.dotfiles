# Nushell Environment Config File

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIR = ($nu.config-path | path dirname | path join 'lib')

$env.NU_LIB_DIRS = [
    $env.NU_LIB_DIR
]

$env.DEFAULT_CONFIG_FILE = (
  $env.NU_LIB_DIR
  | path join "default_config.nu"
)

$env.ENV_CONVERSIONS = {
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
$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'lib')
]

# Directories to search for plugin binaries when calling register
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

####################################
############ HOMEBREW ##############
####################################
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')


####################################
############## CARGO ###############
####################################
$env.PATH = ($env.PATH | prepend ([$env.HOME '.cargo/bin'] | path join))

# FNM
# load env variables
fnm env --json | from json | load-env

# add dynamic fnm path
$env.PATH = ($env.PATH | append [$"($env.FNM_MULTISHELL_PATH)/bin"])
# FNM END #

# Adding homebrew bison to PATH
$env.PATH = ($env.PATH | prepend '/opt/homebrew/opt/bison/bin')

# Adding Bazel to path
$env.PATH = ($env.PATH | prepend '/opt/homebrew/opt/bazel/bin')

# Go
$env.GOPATH = ([$env.HOME 'go'] | path join)
$env.PATH = ($env.PATH | prepend '/usr/local/go/bin')
$env.PATH = ($env.PATH | prepend ([$env.GOPATH 'bin'] | path join))


# Docker binaries
$env.PATH = ($env.PATH | prepend '/Applications/Docker.app/Contents/Resources/bin')

# Python
$env.PATH = ($env.PATH | prepend '/Library/Frameworks/Python.framework/Versions/Current/bin')
alias python = python3
alias py = python3
alias pip = pip3

zoxide init nushell | save -f ~/.zoxide.nu
