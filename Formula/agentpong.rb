class Agentpong < Formula
  desc "Pixel art room with husky pet that monitors Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentpong"
  url "https://github.com/ericermerimen/agentpong/releases/download/v1.2.2/AgentPong-v1.2.2-macos.tar.gz"
  sha256 "2b02d8428228d65da1de0dfe1f0c3c79454df4f633293dfce73f23eaf3231071"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentPong.app"
    bin.install_symlink prefix/"AgentPong.app/Contents/MacOS/AgentPong" => "agentpong"
  end

  def caveats
    <<~EOS
      Start AgentPong and auto-launch on login:

        brew services start agentpong

      Setup Claude Code hooks:

        agentpong setup

      After future upgrades:

        brew upgrade agentpong && brew services restart agentpong
    EOS
  end

  def post_install
    quiet_system "pkill", "-x", "AgentPong"
    quiet_system "rm", "-rf", "/Applications/AgentPong.app"
    quiet_system "cp", "-R", "#{opt_prefix}/AgentPong.app", "/Applications/AgentPong.app"
  end

  service do
    run [opt_prefix/"AgentPong.app/Contents/MacOS/AgentPong"]
    keep_alive true
    log_path var/"log/agentpong.log"
    error_log_path var/"log/agentpong-error.log"
  end
end
