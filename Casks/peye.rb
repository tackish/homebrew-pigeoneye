cask "peye" do
  version "0.0.2"

  on_arm do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-arm64.tar.gz"
    sha256 "41ece21399aeabc0771358a0782d8805f777bf1bdef402717d27b98733363b11"
  end
  on_intel do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-x86_64.tar.gz"
    sha256 "2975dfae1d2395a4ad51ccb7c198d76f2950507a1acc028a27c704d480e32d23"
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
