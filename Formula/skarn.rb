class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.31.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.31.0/skarn-aarch64-macos.tar.gz"
      sha256 "4340490064b27b8478d679a7b4c87925247c4a92e470a1a7300f6de0f55a5748"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.31.0/skarn-x86_64-macos.tar.gz"
      sha256 "571b83a71a84876edb98590d18cdea1e84dde8dcfe30b6f2a294098c1fb2e514"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.31.0/skarn-aarch64-linux.tar.gz"
      sha256 "b09f225d3afe2ca9ad74f93afce6ae0f6b66a65079c9a3bea0cc7f86a6dd4269"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.31.0/skarn-x86_64-linux.tar.gz"
      sha256 "c2d50e3c932205887ed705c93bb7d7c95ba854670d23204c4edeeeac47742dbd"
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
