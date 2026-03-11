class Agentping < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentping"
  url "https://github.com/ericermerimen/agentping/releases/download/v0.5.4/AgentPing-v0.5.4-macos.tar.gz"
  sha256 "d0547569f73e7a51249ce5536cbc01b659b969e635e0b21b7f0b7d523486c67c"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPing.app"
    bin.install_symlink prefix/"AgentPing.app/Contents/MacOS/agentping"
  end

  def post_install
    ohai "Linking AgentPing.app to /Applications..."
    system "ln", "-sf", "#{prefix}/AgentPing.app", "#{ENV["HOME"]}/Applications/AgentPing.app" if Dir.exist?("#{ENV["HOME"]}/Applications")
  end

  def caveats
    <<~EOS
      To add AgentPing to /Applications, run:
        sudo cp -pR #{opt_prefix}/AgentPing.app /Applications/

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
