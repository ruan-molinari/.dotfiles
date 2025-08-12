# Replace environment variables in a string. Accepts $VAR and ${VAR} syntax. Handles $PATH.
export def "str replace-env" [
    --overlay: record = {} # Use this record as an overlay over the environment
] {
    # Replace PATH first, from overlay if it exists
    let in_string = $in | str replace --all --regex '\$PATH|\$\{PATH\}' (
        $overlay.PATH? | default $env.PATH | str join (char esep)
    )
    # Parse env variables and look them up in $env
    ($in_string |
        parse --regex '(?<match>\$(?<var0>\w+)|\$\{(?<var1>\w+)\})' |
        uniq |
        reduce --fold $in_string { |var, s|
            # Env key has been parsed into either the var0 group or the var1 group
            let env_key = [$var.var0 $var.var1] | where not ($in | is-empty) | first
            # Get from either the overlay or $env
            let replacement = $overlay | get -o $env_key | default ($env | get $env_key)
            $s | str replace --all $var.match $replacement
        })
} 
 
# Read an environment file / bash script. Will substitute $VAR, and ignores `export`
export def "from env" [] {
    lines |
        parse -r `^(?:export )?(?<name>\w+) *= *(?<quote>['"]?)(?<value>.*)\k<quote>$` |
        # Handle environment variables that update previously set ones, and env substitutions
        reduce --fold {} { |var, out|
            $out | upsert $var.name ($var.value | str replace-env --overlay=$out)
        }
}

# Write an environment file.
export def "to env" [
    --export # Start definitions with `export`, for sourcing in Bourne-like shells
    --quote # Quote the values
] {
    transpose key value | each { |it|
        $"(if $export { 'export ' })($it.key)=($it.value | if $quote { to json } else { $in })"
    } | str join "\n"
}


# Credits
# github.com/devyn - dotenv parsing scripts
