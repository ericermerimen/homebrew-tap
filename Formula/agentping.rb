class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.6.6/AgentPing-v0.6.6-macos.tar.gz"
  sha256 "c4974134574cc003f5dfa55fd48449178a2626ab056a2be17e843a0b39d33488"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def caveats
    <<~EOS
      To launch AgentPing, run:
        open #{opt_prefix}/AgentPing.app

      Or copy to ~/Applications for Spotlight/Launchpad access:
        mkdir -p ~/Applications && cp -pR #{opt_prefix}/AgentPing.app ~/Applications/

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
