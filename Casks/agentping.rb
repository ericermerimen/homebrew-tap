cask "agentping" do
  version "0.12.1"
  sha256 "bc2580b5245ce2ee486cff8b984ca8490f8223a6569bab6e4b93fb90b70b977d"

  url "https://github.com/ericermerimen/agentping/releases/download/v#{version}/AgentPing-v#{version}-macos.tar.gz"
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
         (System Settings > Privacy & Security > Accessibility)
      3. Open Preferences > "Copy Hook Config to Clipboard"
      4. Paste into ~/.claude/settings.json
      5. Restart your Claude Code sessions

    AgentPing updates automatically via Sparkle.
    To enable launch at login, use the app's Preferences.
  EOS
end
