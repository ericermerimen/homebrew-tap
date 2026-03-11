class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.6.7/AgentPing-v0.6.7-macos.tar.gz"
  sha256 "406682e6b8d64cceb5a5828260984122bdded124a09a5401c66388891e45d343"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def caveats
    <<~EOS

      ╔══════════════════════════════════════════════════╗
      ║  IMPORTANT: Run this to start AgentPing         ║
      ╚══════════════════════════════════════════════════╝

        open #{opt_prefix}/AgentPing.app

      To add to ~/Applications (Spotlight + Launchpad):

        mkdir -p ~/Applications && cp -pR #{opt_prefix}/AgentPing.app ~/Applications/

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
