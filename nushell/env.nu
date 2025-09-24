#try {
#  use ~/.secrets/env.nu
#}

source '../scripts/util.nu'

$env.STARSHIP_SHELL = "nu"


def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# -------------------------------------------------
# -- PATH additions from now on
# -------------------------------------------------

# Executable binaries go in this dir.
# Make a symlink to a compiled binary in this dir,
# this is especially practical for applications built from source
$env.BIN = ([$env.HOME bin] | path join)

$env.BUN_ROOT = ([$env.HOME .bun] | path join)
$env.BUN_CACHE = ([$env.HOME .cache .bun] | path join)
$env.CARGO = ([$env.HOME .cargo] | path join)

# `N` Node version manager
$env.N_PREFIX = ([$env.HOME n] | path join)

# Zig Version Manager:w
$env.ZVM_INSTALL = ([$env.HOME .zvm] | path join)


# Env variable for any system
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | append $env.BIN
    | append ([$env.BUN_ROOT bin] | path join)
    | append ([$env.BUN_CACHE bin] | path join)
    | append ([$env.CARGO bin] | path join)
    | append ([$env.N_PREFIX bin] | path join)

    | append ([$env.ZVM_INSTALL bin] | path join)
    | append ([$env.ZVM_INSTALL self] | path join)

    | append ([$env.HOME '.local' 'bin'] | path join)
    | uniq # filters so the paths are unique
    )

if $nu.os-info.name == macos { # env variables for macos
  $env.PATH = (
      $env.PATH
      | split row (char esep)
      | append '/opt/homebrew/bin'
      | append '/opt/podman/bin'
      | uniq
      )

} else if $nu.os-info.name == linux { # env variables for linux
  $env.PATH = (
      $env.PATH
      | split row (char esep)
      | uniq
      )
}

# -------------------------------------------------
