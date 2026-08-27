class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.26.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.26.0/skarn-aarch64-macos.tar.gz"
      sha256 "3c3111942bb019f9cdb0e2e43dae76662406877ddfabe6e82ab3ee9c45b05276"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.26.0/skarn-x86_64-macos.tar.gz"
      sha256 "22d6a16cf57b4aabd8fe96e760da4a641b398b54cfb774831ac056b16fdaef1b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.26.0/skarn-aarch64-linux.tar.gz"
      sha256 "1f6b06535aceb78bfbfa6189ea6371a7cbb22cb91e7a5f8465cadb3bf03af752"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.26.0/skarn-x86_64-linux.tar.gz"
      sha256 "fa97fa310294a840b68dd4625aae9e3501fb5369300da6359d4831a9ff138109"
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
