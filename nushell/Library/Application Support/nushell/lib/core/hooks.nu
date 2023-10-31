export def main [] {
  {
    pre_prompt: [{
      $nothing  # replace with source code to run before the prompt is shown
    }]
    pre_execution: [{
      $nothing  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [
       # {
       #   condition: {|_, after|
       #     ('activate' not-in (overlay list)
       #      and ($after | path join venv/bin/activate.nu | path exists))
       #   }
       #   code: "overlay use venv/bin/activate.nu"
       # }
       # {
       #   condition: {|before, after|
       #     ('activate' in (overlay list)
       #       and ($after | path join venv/bin/activate.nu | path exists) == false
       #      )
       #   }
       #   code: "overlay hide activate"
       # }
      ]
    }
  }
}
