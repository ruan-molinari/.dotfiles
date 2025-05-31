def "aoc input get-all" [year: string] {
  for $day in 1..31 {
    print $"Fetching day ($day)..."
    try {
      aoc input get $year $day
    }
  }
}

def "aoc input get" [year: string day: int] {
  if (ls | find inputs | length | $in == 0) {
    mkdir inputs
  };
  try {
    http get --headers ['Cookie' $env.AOC_SESSION_TOKEN] $"https://adventofcode.com/($year)/day/($day)/input"
    | save $"inputs/day_($day)"
  } catch { 
    |err|
      print $err;
  }
}

# TODO: make a command to set session-token or authentication.
# this will release the need to set an environment variable
# for it.
def "aoc set-session-token" [session_token: string] {
  $env.AOC_SESSION_TOKEN = $"session=($session_token)";
}

