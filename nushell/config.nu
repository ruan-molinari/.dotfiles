# TODO: see if there is a way to do this in nix instead
alias nix-shell = nix-shell --command nu
alias vim = nvim

$env.config = {
  ls: {
    use_ls_colors: true
  }
  rm: {
    always_trash: false
  }

  table: {
    mode: compact # "basic", "compact", "compact_double", "light", "thin", "with_love", "rounded", "reinforced", "heavy", "none", "other"
    index_mode: auto # "auto" (shows indexes when table has indexes), "always", "never" 
    trim: {
      methodology: wrapping # "wrapping" or "truncating"
      wrapping_try_keep_words: true
      truncating_suffix: "..."
    }
  }

  explore: {
    help_banner: true
    exit_esc: true

    table: {
      cursor: true

      line_index: true
      line_shift: true
      line_head_top: true
      line_head_bottom: true

      show_head: true
      show_index: true
    }
  }

  history: {
    max_size: 10000
    sync_on_enter: true
    file_format: "plaintext" # "sqlite" or "plaintext"
  }
  completions: {
    case_sensitive: false
    quick: true # set to false to prevent auto-selecting completions when only one remains
    partial: true # set this to false to prevent partial filling of the prompt
    algorithm: "prefix" # "prefix" or "fuzzy"
  }
  filesize: {
    unit: binary
  }
  footer_mode: 25 # "always", "never", numbel_of_rows, "auto"
  float_precision: 2
  use_ansi_coloring: true
  edit_mode: vi
  show_banner: false
  render_right_prompt_on_last_line: false
  shell_integration: {
    # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
    osc2: true
    # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
    osc7: true
    # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it. show_clickable_links is deprecated in favor of osc8
    osc8: true
    # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
    osc9_9: false
    # osc133 is several escapes invented by Final Term which include the supported ones below.
    # 133;A - Mark prompt start
    # 133;B - Mark prompt end
    # 133;C - Mark pre-execution
    # 133;D;exit - Mark execution finished with exit code
    # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
    osc133: true
    # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
    # 633;A - Mark prompt start
    # 633;B - Mark prompt end
    # 633;C - Mark pre-execution
    # 633;D;exit - Mark execution finished with exit code
    # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
    # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
    # and also helps with the run recent menu in vscode
    osc633: true
    # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
    reset_application_mode: true
  }
}

# Startup
fastfetch --config examples/13
#source $"($nu.home-path)/.cargo/env.nu" # TODO: returning error. do not remember why this is here
