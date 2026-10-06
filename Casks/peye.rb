cask "peye" do
  version "1.4.5"

  on_arm do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-arm64.tar.gz"
    sha256 "3de8c56d36460169b725defe0b7df33fb29a57f06c574d35d1bcf71da19e97bd"
  end
  on_intel do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-x86_64.tar.gz"
    sha256 "b79448ff43c8675b6b778dc9f5394fd12e951ed8c280ffb0282628e1c44873ee"
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
