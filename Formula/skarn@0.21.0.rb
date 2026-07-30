class SkarnAT0210 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.21.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.21.0/skarn-aarch64-macos.tar.gz"
      sha256 "c2965a5268f8ddfcd01c62fa70f54dac492a11e595e6f5aa87a4a1ce5f6ab617"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.21.0/skarn-x86_64-macos.tar.gz"
      sha256 "7e5b0f463a212b9b80c1ceceb0232b824a304381a7837651b756cfbfad4255e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.21.0/skarn-aarch64-linux.tar.gz"
      sha256 "09b0017c1cf0ba7a0ca8035effd6e7b9aad5bb586f3d9cc49ca0f995cfef2b7c"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.21.0/skarn-x86_64-linux.tar.gz"
      sha256 "ce03e51ce1e7bc69fab9afae7bcc97e7cc624d0a56316287a80fc5baa77822b7"
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
