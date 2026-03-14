### 🛠️ Changing variables for your needs:
Open variables.nix and change everything you need.<br>
For instance, location of hyprland configuration.

### ➡️ Where files will be saved?
Configurations (.nix files): `/Users/Account/maconlyos`<br>
Shared dotfiles: `/Users/Account/maconlyos/shared`

### 🔄️ How to install/update system?

#### Installation:
1. `sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)`<br>
2. `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`<br>
3. `git clone https://gitlab.com/al1h3n/molnios-install.git`<br>
4. `sudo sh molnios.sh -f`

#### Manual updating (in configurations folder):
1. `nix flake update --flake .#main`
2. `darwin-rebuild switch --impure --flake .#main`

### 🕝 When to install?
Install MaconlyOS right after you had installed macOS. 