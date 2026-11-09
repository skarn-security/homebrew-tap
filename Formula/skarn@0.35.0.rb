class SkarnAT0350 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.35.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.35.0/skarn-aarch64-macos.tar.gz"
      sha256 "a1d615dfab57cf0710e64815c545b5c847027e1e177fa0875c8b28c6c02d58a6"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.35.0/skarn-x86_64-macos.tar.gz"
      sha256 "485958fef87f7b784c999ca2842089953602148d23543be3f95f3a1b851e1a14"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.35.0/skarn-aarch64-linux.tar.gz"
      sha256 "bf22fe6a20c1ce9761c4a48b9ee4e34987874873ee26265492a7e7223fd6d2b3"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.35.0/skarn-x86_64-linux.tar.gz"
      sha256 "ff6ac3ed44acfb8c8109eb5e94b1d7ec14a4259bd54024e7a6e7a869a5ec6c5f"
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
