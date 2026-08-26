class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.25.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.25.0/skarn-aarch64-macos.tar.gz"
      sha256 "bc2d9daf3fa22aa6d9cecc28a9588c1034eb1b3703f0a43b27a1f0b642e2e24c"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.25.0/skarn-x86_64-macos.tar.gz"
      sha256 "78e2df3d7da39e7a30ade7a83eda141e6c3c618b60acf86ff94c4e0b3723d2c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.25.0/skarn-aarch64-linux.tar.gz"
      sha256 "adaaa2d16e45423afb1ece395fc16b213ef4b1fb58c18473f226aa491063cf3e"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.25.0/skarn-x86_64-linux.tar.gz"
      sha256 "b10492c4cdb8cbb195a8a78e040b1d106541dc5341f9a61b152d3f76f16a32ea"
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
