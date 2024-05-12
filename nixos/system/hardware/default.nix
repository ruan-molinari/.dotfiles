{
  pkgs,
  inputs,
  ...
}: {
  imports = 
    [
      inputs.xremap-flake.nixosModules.default
    ];

  services = {
    xremap = {
      withHypr = true;
      userName = "ruan";
      config = {
        modmap = [
          {
            name = "Razer Tartarus WoW";
            remap = {
              # First row is by default  | 1 | 2 | 3 | 4 | 5 |

              # Second row
              "KEY_TAB" = "KEY_Q";
              "KEY_Q"   = "KEY_W";
              "KEY_W"   = "KEY_F";
              "KEY_F"   = "KEY_P";
              "KEY_P"   = "KEY_G";

              # Third row
              "KEY_BACKSPACE" = "KEY_A";
              "KEY_A"         = "KEY_R";
              "KEY_R"         = "KEY_S";
              "KEY_S"         = "KEY_T";
              "KEY_T"         = "KEY_D";

              # Fourth row
              "KEY_LEFTSHIFT" = "KEY_Z";
              "KEY_Z"         = "KEY_X";
              "KEY_X"         = "KEY_C";
              "KEY_C"         = "KEY_V";
            };
            device: "Razer Razer Tartarus Pro";
          }
        ];
      };
    };
  };
}
