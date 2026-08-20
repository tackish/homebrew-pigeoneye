cask "peye" do
  version "1.0.1"

  on_arm do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-arm64.tar.gz"
    sha256 "658399efc89780609e797bbf92517515b74b4796020ef6dbaf891a180f71f03f"
  end
  on_intel do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-x86_64.tar.gz"
    sha256 "5405a95d342f00d710eb867a15fece3192be4d5b26b2f7f12fa445a388b17d35"
  end

  name "PigeonEye"
  desc "A bird's-eye view of your clusters"
  homepage "https://github.com/tackish/pigeoneye"

  app "PigeonEye.app"
  # Launch it from the terminal like k9s: `peye` opens the app. Symlinks
  # the app's own executable, so it's a real launcher, not a wrapper.
  binary "#{appdir}/PigeonEye.app/Contents/MacOS/PigeonEye", target: "peye"

  # The app is ad-hoc signed but not notarized, so Homebrew's quarantine
  # flag makes Gatekeeper block the first launch. Clear it on install so
  # `peye` / double-click just work. (Drop this once we notarize.)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/PigeonEye.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.tackish.pigeoneye",
    "~/Library/Caches/dev.tackish.pigeoneye",
    "~/Library/WebKit/dev.tackish.pigeoneye",
  ]
end
