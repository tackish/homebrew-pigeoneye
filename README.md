# homebrew-pigeoneye

Homebrew tap for [PigeonEye](https://github.com/tackish/pigeoneye) — a fast,
native Kubernetes GUI.

```sh
brew tap tackish/pigeoneye
brew install --cask peye
```

Then launch it from Spotlight, or just type `peye` in a terminal.

The cask here is updated automatically by PigeonEye's release workflow — it
points at the release binaries published on the
[main repo](https://github.com/tackish/pigeoneye/releases). Don't edit
`Casks/peye.rb` by hand; it gets overwritten on the next release.
