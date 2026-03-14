class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.10.2/AgentPing-v0.10.2-macos.tar.gz"
  sha256 "7c50ab11dc3723a7633b01c34df5d2dee8b8ffc2c67da791e7aba23b4e8877d4"

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
