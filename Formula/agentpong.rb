class Agentpong < Formula
  desc "Pixel art room with husky pet that monitors Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentpong"
  url "https://github.com/ericermerimen/agentpong/releases/download/v1.1.0/AgentPong-v1.1.0-macos.tar.gz"
  sha256 "91a747921920524822d68a6b31d8eabb3a3a051983679b342cc23249c5790b57"

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
