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
      withX11 = true;
      #withGnome = true;
      userName = "ruan";

      config = {
        modmap = [
          {
            name = "Razer Tartarus WoW";

            # Remaps must be expressed for QUERTY no matter what keyboard layout is being used
            remap = {
              # First row is by default  | 1 | 2 | 3 | 4 | 5 |

              # Second row
              Tab = "Q";
              Q = "W";
              W = "E";
              E = "R";
              R = "T";

              # Third row
              CapsLock = "A";
              A = "S";
              S = "D";
              D = "F";
              F = "G";

              # Fourth row
              LEFTSHIFT = "Z";
              Z = "X";
              X = "C";
              C = "V";
            };
            device = {
              only = "Razer Razer Tartarus Pro";
            };
          }
        ];
      };
    };
  };
}
