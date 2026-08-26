{
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    (
      # -*- Data & Configuration Languages -*-#
      [
        #-- nix
        nil
        nixd
        statix # Lints and suggestions for the nix programming language
        deadnix # Find and remove unused code in .nix source files
        nixfmt # Nix Code Formatter

        #-- json like
        terraform-ls
        jsonnet
        jsonnet-language-server
        taplo # TOML language server / formatter / validator
        yaml-language-server
        actionlint # GitHub Actions linter

        #-- dockerfile
        hadolint # Dockerfile linter
        dockerfile-language-server

        #-- markdown
        marksman # language server for markdown
        glow # markdown previewer
        pandoc # document converter

        #-- sql
        sqlfluff

        #-- protocol buffer
        buf # linting and formatting
      ]
      ++
        #-*- General Purpose Languages -*-#
        [
          #-- c/c++
          cmake
          cmake-language-server
          gnumake
          checkmake
          # c/c++ compiler, required by nvim-treesitter!
          gcc
          gdb
          # c/c++ tools with clang-tools, the unwrapped version won't
          # add alias like `cc` and `c++`, so that it won't conflict with gcc
          # llvmPackages.clang-unwrapped
          clang-tools
          lldb

          #-- python
          uv # python project package manager
          ruff
          ty
          basedpyright
          (python314.withPackages (
            ps: with ps; [
              #More LSPs
              python-lsp-server
              pylsp-mypy

              # my commonly used python packages
	            pwntools
              jupyter
              ipython
              pandas
              numpy
              requests
              pyquery
              pyyaml
              protobuf # protocol buffer compiler
            ]
          ))

          #-- rust
          # we'd better use the rust-overlays for rust development
          rustc
          rustup
          rust-analyzer
          cargo # rust package manager
          rustfmt
          clippy # rust linter
          package-version-server # rust package version LSP

          #-- golang
          go
          gomodifytags
          iferr # generate error handling code for go
          impl # generate function implementation for go
          # gotools # contains tools like: godoc, goimports, etc.
          gopls # go language server
          delve # go debugger

          # -- java
          # jdk25
          # gradle
          # maven
          # spring-boot-cli
          # jdt-language-server

          #-- lua
          stylua
          lua-language-server

          #-- bash
          bash-language-server
          shellcheck
          shfmt
        ]
      #-*- Web Development -*-#
      ++ [
        nodejs_24
        pnpm
        typescript
        typescript-language-server
        bun
        # HTML/CSS/JSON/ESLint language servers extracted from vscode
        vscode-langservers-extracted
        tailwindcss-language-server
        emmet-ls
      ]
      ++ [
        proselint # English prose linter

        #-- Optional Requirements:
        prettier # common code formatter
        color-lsp
        fzf
        gdu # disk usage analyzer, required by AstroNvim
        (ripgrep.override { withPCRE2 = true; }) # recursively searches directories for a regex pattern
      ]
    );
}

