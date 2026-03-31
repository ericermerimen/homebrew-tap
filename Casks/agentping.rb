cask "agentping" do
  version ""
  sha256 "83da98a5c5e705f5467b897b96e70886c9db41b663e28fab1638df3c8904ee82"

  url "https://github.com/ericermerimen/agentping/releases/download/v0.12.2/AgentPing-v0.12.2-macos.tar.gz"
  name "AgentPing"
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"

  depends_on macos: ">= :sonoma"

  app "AgentPing.app"
  binary "#{appdir}/AgentPing.app/Contents/MacOS/agentping"

  postflight do
    system "pkill", "-x", "AgentPingApp"
  end

  caveats <<~EOS
    After install:
      1. Open AgentPing from Applications
      2. Grant Accessibility access when prompted
      3. Open Preferences > "Copy Hook Config to Clipboard"
      4. Paste into ~/.claude/settings.json

    AgentPing updates automatically via Sparkle.
  EOS
end
