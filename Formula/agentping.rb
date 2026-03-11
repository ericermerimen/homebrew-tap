class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.6.4/AgentPing-v0.6.4-macos.tar.gz"
  sha256 "7f4b88f909693ab5a4ff19b7f9acd2edc3a36660a8614075ae1ff6b6f77114b6"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def post_install
    user_apps = Pathname(Dir.home)/"Applications"
    user_apps.mkpath
    target = user_apps/"AgentPing.app"
    target.rmtree if target.exist?
    FileUtils.cp_r "#{prefix}/AgentPing.app", target.to_s
    ohai "AgentPing.app installed to #{user_apps}/"

    # Clean up old /Applications copy if it exists
    system_target = Pathname("/Applications/AgentPing.app")
    if system_target.exist?
      begin
        system_target.rmtree
        ohai "Removed old copy from /Applications/"
      rescue Errno::EACCES
        opoo "Old AgentPing.app in /Applications/ can be removed with: sudo rm -rf /Applications/AgentPing.app"
      end
    end
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
