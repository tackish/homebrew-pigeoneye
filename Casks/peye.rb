cask "peye" do
  version "0.7.0"

  on_arm do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-arm64.tar.gz"
    sha256 "c5933c3118eb8442a9531759927d2026fc5181897970de2815e728c512c4f3a5"
  end
  on_intel do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-x86_64.tar.gz"
    sha256 "ca6d6c9d03654ea9cc6cc66727d3d74079b48b087138261dba5eccb672a3ac00"
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
