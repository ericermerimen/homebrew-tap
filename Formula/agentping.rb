class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.6.5/AgentPing-v0.6.5-macos.tar.gz"
  sha256 "29a6133dca588c4cdb8025e3e40b8245efb3826160cd77d07aa859f2a78d89b1"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def post_install
    user_apps = Pathname(Dir.home)/"Applications"
    system "mkdir", "-p", user_apps.to_s
    system "rm", "-rf", (user_apps/"AgentPing.app").to_s
    system "cp", "-pR", "#{prefix}/AgentPing.app", user_apps.to_s
  end

  def caveats
    <<~EOS
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
