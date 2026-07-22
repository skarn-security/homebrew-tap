class SkarnAT0200 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.20.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.20.0/skarn-aarch64-macos.tar.gz"
      sha256 "22518dccf0a9dfe1a8567db9beb05d3f36e0085ae876ac7745dcbf55b8d13c0a"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.20.0/skarn-x86_64-macos.tar.gz"
      sha256 "bc58bfc927d78393dc66dc1bca54074def149dda9867b24b66bb7971ee15473c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.20.0/skarn-aarch64-linux.tar.gz"
      sha256 "59ae46017f3f7c3f7a807b6acc528f20ae97f09f44c2067fc940dee3c7f3c8fb"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.20.0/skarn-x86_64-linux.tar.gz"
      sha256 "72e1ca3b63ec12c60c9d66bb4eb4a0d8c0e664419b30f8087d7bf09ddb53cb62"
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
