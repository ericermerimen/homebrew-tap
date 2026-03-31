cask "agentpong" do
  version "1.2.2"
  sha256 "2b02d8428228d65da1de0dfe1f0c3c79454df4f633293dfce73f23eaf3231071"

  url "https://github.com/ericermerimen/agentpong/releases/download/v#{version}/AgentPong-v#{version}-macos.tar.gz"
  name "AgentPong"
  desc "Pixel art room with husky pet that monitors Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentpong"

  depends_on macos: ">= :sonoma"

  app "AgentPong.app"
  binary "#{appdir}/AgentPong.app/Contents/MacOS/AgentPong", target: "agentpong"

  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/AgentPong.app"]
    system "pkill", "-x", "AgentPong"
  end

  caveats <<~EOS
    After install:
      1. Open AgentPong from Applications
      2. Run `agentpong setup` to configure Claude Code hooks

    AgentPong updates automatically via Sparkle.
    To enable launch at login, use the app's menu.
  EOS
end
