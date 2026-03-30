class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  # URL and sha256 are updated automatically by the release workflow
  url "https://github.com/ericermerimen/agentping/releases/download/v0.11.0/AgentPing-v0.11.0-macos.tar.gz"
  sha256 "ab0dbe9badb8f26ce6aebab544ae4c58f2634b98bfc60ae7e9717277d0638e87"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def caveats
    <<~EOS
      AgentPing.app has been installed to:
        #{prefix}/AgentPing.app

      To start the menu bar app:
        open #{prefix}/AgentPing.app

      To set up Claude Code hooks, open AgentPing preferences
      and click "Copy Hook Config to Clipboard", then paste
      into ~/.claude/settings.json

      You may need to grant Accessibility access in:
        System Settings > Privacy & Security > Accessibility
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
