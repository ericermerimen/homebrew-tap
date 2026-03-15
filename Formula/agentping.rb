class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.10.3/AgentPing-v0.10.3-macos.tar.gz"
  sha256 "b89986097fd10253edef99f2077637e7e0243663160459db269e91e50bb3b59d"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def caveats
    <<~EOS
      To start AgentPing and auto-launch on login:

        brew services start agentping

      After future upgrades:

        brew upgrade agentping && brew services restart agentping

      Next steps:
        1. Grant Accessibility access when prompted
           (System Settings > Privacy & Security > Accessibility)
        2. Open Preferences > "Copy Hook Config to Clipboard"
        3. Paste into ~/.claude/settings.json
        4. Restart your Claude Code sessions
    EOS
  end

  def post_install
    # Kill any running AgentPing so brew services restart picks up the new binary
    quiet_system "pkill", "-x", "AgentPingApp"
  end

  service do
    run [opt_prefix/"AgentPing.app/Contents/MacOS/AgentPingApp"]
    keep_alive true
    log_path var/"log/agentping.log"
    error_log_path var/"log/agentping-error.log"
  end
end
