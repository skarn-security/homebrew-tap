class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.34.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.34.0/skarn-aarch64-macos.tar.gz"
      sha256 "d98ed7324a7a7442af9fbbb1ba234363a51dd5c1d865d8e5bf1b7bf8fe86f1b0"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.34.0/skarn-x86_64-macos.tar.gz"
      sha256 "bc64a77214e03c087af038cf9084258eab7f21c76c9141bde7af88ac7896df0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.34.0/skarn-aarch64-linux.tar.gz"
      sha256 "ef44b73de11495047ad35c9418311b20255991f3a54308afe6442aa386e50d70"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.34.0/skarn-x86_64-linux.tar.gz"
      sha256 "2f5874d2289f5a74daac9ec1939f556807457e37741bbb701460c475e6305955"
    end
  end

  def install
    bin.install "skarn"
    generate_completions_from_executable(bin/"skarn", "completion")
    man1.install Dir["skarn*.1"]
    doc.install "EULA.md", "THIRD-PARTY-NOTICES.md", "EDITIONS.md"
  end

  def caveats
    <<~EOS
      Get started:
        1. Scan this machine:                     skarn assess
        2. Get and install your free license:     skarn license ~/Downloads/<your>.skarnlicense
        3. Wire the AI-agent guard:               skarn setup
        4. Verify it's working:                   skarn doctor

      skarn assess needs no license. skarn check scans need one - get the free
      license at https://getskarn.com/free after a quick email confirmation.
      License status:  skarn license
      Manual:          man skarn

      Skarn is licensed under the Skarn End User License Agreement:
        installed at #{doc}/EULA.md and published at https://getskarn.com/terms/
      Skarn asks for your acceptance the first time you run it; running it
      constitutes acceptance.
    EOS
  end

  test do
    assert_match "skarn #{version}", shell_output("#{bin}/skarn --version")
  end
end
