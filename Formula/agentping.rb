class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.6.11/AgentPing-v0.6.11-macos.tar.gz"
  sha256 "a74bbcbc83429c24d96c59a5460c66fbc6ff207ade305f98dd5ec2001ac79d8f"

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

  service do
    run [opt_prefix/"AgentPing.app/Contents/MacOS/AgentPingApp"]
    keep_alive true
    log_path var/"log/agentping.log"
    error_log_path var/"log/agentping-error.log"
  end
end
