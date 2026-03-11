class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.5.0/AgentPing-v0.5.0-macos.tar.gz"
  sha256 "fca49e621f21af757ad0c633d5f0a70eebac486d0ea0a3b6ba4ba51faeee6e43"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def post_install
    ln_sf prefix/"AgentPing.app", "/Applications/AgentPing.app"
  end

  def caveats
    <<~EOS
      AgentPing.app has been linked to /Applications.

      To set up Claude Code hooks, open AgentPing preferences
      and click "Copy Hook Config to Clipboard", then paste
      into ~/.claude/settings.json

      You may need to grant Accessibility access in:
        System Settings > Privacy & Security > Accessibility
    EOS
  end

  service do
    run [opt_prefix/"AgentPing.app/Contents/MacOS/AgentPingApp"]
    keep_alive true
    log_path var/"log/agentping.log"
    error_log_path var/"log/agentping-error.log"
  end
end
