class Agentshub < Formula
  desc "macOS menu bar app for monitoring Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentshub"
  url "https://github.com/ericermerimen/agentshub/releases/download/v0.2.1/AgentsHub-v0.2.1-macos.tar.gz"
  sha256 "ded856786b726d51cf0a989e1994df3ccb8f462fa2516e7c57cf1f975d0ea74d"

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
