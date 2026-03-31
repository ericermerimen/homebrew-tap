cask "agentpong" do
  version ""
  sha256 "1a69a21a0ad236fd6e962f6215ec7ce0ecaabb6504178850419723f248ccec4b"

  url "https://github.com/ericermerimen/agentpong/releases/download/v1.2.3/AgentPong-v1.2.3-macos.tar.gz"
  name "AgentPong"
  desc "Pixel art room with husky pet that monitors Claude Code sessions"
  homepage "https://github.com/ericermerimen/agentpong"

  depends_on macos: ">= :sonoma"

  app "AgentPong.app"
  binary "#{appdir}/AgentPong.app/Contents/MacOS/AgentPong", target: "agentpong"

  postflight do
    system "pkill", "-x", "AgentPong"
  end

  caveats <<~EOS
    After install:
      1. Open AgentPong from Applications
      2. Run `agentpong setup` to configure Claude Code hooks

    AgentPong updates automatically via Sparkle.
  EOS
end
