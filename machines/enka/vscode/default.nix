{
  lib,
  pkgs,
  homeConfiguration,
  homePackages,
  enabled,
  ...
}:

let
  plugin = publisherDotName: version: sha256: [(

    let 
      splitted = lib.strings.splitString "." publisherDotName;
    in
    
    pkgs.vscode-utils.extensionFromVscodeMarketplace {
      publisher = builtins.elemAt splitted 0;
      name = builtins.elemAt splitted 1;
      inherit version sha256;
    })
  ];
in
homeConfiguration "nixos" {
  programs.vscode = enabled {
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      # THEMES
      dracula-theme.theme-dracula
      github.github-vscode-theme

      # AI
      github.copilot
      github.copilot-chat

      # GIT
      eamodio.gitlens
      github.vscode-pull-request-github
      github.vscode-github-actions
      github.codespaces

      # MISC

      ## WAKATIME
      wakatime.vscode-wakatime

      ## TODO
      gruntfuggly.todo-tree


      # VIM
      vscodevim.vim
      
      # LANGUAGES
      ## NIX
      bbenoist.nix
      jnoortheen.nix-ide

      ## RUST
      rust-lang.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml

      ## ZIG
      # ziglang.vscode-zig

      ## Markdown
      yzhang.markdown-all-in-one
      davidanson.vscode-markdownlint

      ## C/C++
      ms-vscode.cpptools

      # Debuggers
      vadimcn.vscode-lldb # C/C++ Rust


      ## CMAKE
      ms-vscode.cmake-tools

      # jscearcy.rust-doc-viewer
      # lorenzopirro.rust-flash-snippets
      # zhangyue.rust-mod-generator
      # swellaby.vscode-rust-test-adapter
      # hdevalke.rust-test-lens
      # panicbit.cargo
      # vadimcn.vscode-lldb
      # dustypomerleau.rust-syntax
    ] 
    # Themes
    ++ plugin "jonathanharty.gruvbox-material-icon-theme" "1.1.5" "sha256-86UWUuWKT6adx4hw4OJw3cSZxWZKLH4uLTO+Ssg75gY="
    
    # Programming Languages
    ## Rust
    ++ plugin "dustypomerleau.rust-syntax"        "0.6.1"  "sha256-o9iXPhwkimxoJc1dLdaJ8nByLIaJSpGX/nKELC26jGU="
    ++ plugin "jscearcy.rust-doc-viewer"          "4.2.0"  "sha256-x1pmrw8wYHWyNIJqVdoh+vasbHDG/A4m8vDZU0DnPzo="
    ++ plugin "zhangyue.rust-mod-generator"       "1.0.10" "sha256-CxlKwUL9NCo+J+m7s4O9uuF+Q7quZC8ePW21d78hCE0="
    ++ plugin "lorenzopirro.rust-flash-snippets"  "3.1.0"  "sha256-IWPvCIWlT8HhKQ5ulUTTLnoVSNMjYhBQiHs7TQdtJzc="
    ++ plugin "swellaby.vscode-rust-test-adapter" "0.11.0" "sha256-IgfcIRF54JXm9l2vVjf7lFJOVSI0CDgDjQT+Hw6FO4Q="
    ++ plugin "evgeniypeshkov.syntax-highlighter" "0.5.0"  "sha256-2XUuI90rVnC8pRUgAOPw3wHa3GcnuGIr2U/qTCn3dKA="
    ++ plugin "mooman219.rust-assist"             "0.2.3"  "sha256-gg7TEyKrQZ+pYRjFvyJy4lElzAbh7l62LZy7KLYxvmQ="
    ++ plugin "hdevalke.rust-test-lens"           "1.0.0"  "sha256-faSBpgFIyqA9F03ghizTyFaB+XOwA1pNrStQlLTV9Pk="
    ++ plugin "belfz.search-crates-io"            "1.2.1"  "sha256-K2H4OHH6vgQvhhcOFdP3RD0fPghAxxbgurv+N82pFNs="
    ++ plugin "panicbit.cargo"                    "0.2.3"  "sha256-B0oLZE8wtygTaUX9/qOBg9lJAjUUg2i7B2rfSWJerEU="
    ++ plugin "franneck94.vscode-rust-config"     "0.4.0"  "sha256-/jLj4cTePQQwVexacqwE7VTjVinp2JgSM6okkdLhDSk="

    # General
    ++ plugin "usernamehw.errorlens"              "3.16.0" "sha256-Y3M/A5rYLkxQPRIZ0BUjhlkvixDae+wIRUsBn4tREFw="
    ++ plugin "sidp.strict-whitespace"            "0.1.0"  "sha256-Os5JWt1WrqYIKrpGUYHEPFTpm9pbO4jZshrp0JvyrDs="
    ++ plugin "hbenl.vscode-test-explorer"        "2.21.1" "sha256-fHyePd8fYPt7zPHBGiVmd8fRx+IM3/cSBCyiI/C0VAg=" # required by rust-test-lens
    ++ plugin "ms-vscode.test-adapter-converter"  "0.1.8"  "sha256-ybb3Wud6MSVWEup9yNN4Y4f5lJRCL3kyrGbxB8SphDs="
    ;
  };
}
