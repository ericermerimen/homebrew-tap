class Agentshub < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentshub"
  url "https://github.com/ericermerimen/agentshub/releases/download/v0.2.0/AgentsHub-v0.2.0-macos.tar.gz"
  sha256 "bfff4e88b1826938c4d6f7314ad0af42f7744a6fa867f28334ff0e4bf5cb7006"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    prefix.install "AgentsHub.app"
    bin.install_symlink prefix/"AgentsHub.app/Contents/MacOS/agentshub"
  end

  def caveats
    <<~EOS
      AgentsHub.app has been installed to:
        #{prefix}/AgentsHub.app

      To start the menu bar app:
        open #{prefix}/AgentsHub.app

      To set up Claude Code hooks, open AgentsHub preferences
      and click "Copy Hook Config to Clipboard", then paste
      into ~/.claude/settings.json

      You may need to grant Accessibility access in:
        System Settings > Privacy & Security > Accessibility
    EOS
  end

  service do
    run "#{prefix}/AgentsHub.app/Contents/MacOS/AgentsHubApp"
    keep_alive true
    log_path var/"log/agentshub.log"
    error_log_path var/"log/agentshub-error.log"
  end
end
