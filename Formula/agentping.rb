class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.6.3/AgentPing-v0.6.3-macos.tar.gz"
  sha256 "03edf66f723365eda5e2236c7671a7354f1b0ec4515490e1e7f84f92bc631938"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def post_install
    ohai "Installing AgentPing.app to /Applications..."
    target = Pathname("/Applications/AgentPing.app")
    begin
      target.rmtree if target.exist?
      FileUtils.cp_r "#{prefix}/AgentPing.app", "/Applications/"
      ohai "AgentPing.app installed to /Applications/"
      ohai "Relaunch AgentPing to use the new version."
    rescue Errno::EACCES
      opoo "Could not copy to /Applications/ (permission denied)."
      opoo "Run: sudo cp -pR #{opt_prefix}/AgentPing.app /Applications/"
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
