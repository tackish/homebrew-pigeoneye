cask "peye" do
  version "1.3.0"

  on_arm do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-arm64.tar.gz"
    sha256 "3ad58054ea4c331397271c595ba836c217a892ad3acffaa2782adfeb3ab72210"
  end
  on_intel do
    url "https://github.com/tackish/pigeoneye/releases/download/v#{version}/PigeonEye-darwin-x86_64.tar.gz"
    sha256 "216431cdecf91a257597d696805e77bf4e7c02a66e720c7088b87b0ac0b00e8a"
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
