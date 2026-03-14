class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.10.0/AgentPing-v0.10.0-macos.tar.gz"
  sha256 "ca4209e84f17865181963d1382152669361650f8f69a4a2e314b7aa5c3e2bf08"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def caveats
    <<~EOS

      ╔══════════════════════════════════════════════════╗
      ║  Run these commands to get started:              ║
      ╚══════════════════════════════════════════════════╝

        brew services start agentping

      This launches AgentPing and auto-starts it on login.
      After future upgrades, run:

        brew upgrade agentping && brew services restart agentping

      ──────────────────────────────────────────────────
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
