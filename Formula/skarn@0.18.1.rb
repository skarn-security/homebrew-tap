class SkarnAT0181 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.18.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.18.1/skarn-aarch64-macos.tar.gz"
      sha256 "097b502f451592e8915c1ce235fe9f6acf17eb5a8a46062b2aa4ef84cee82108"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.18.1/skarn-x86_64-macos.tar.gz"
      sha256 "adbc52e17af16d7ae6b1cccfdcd7684c9109d71fea5891cd0f72a28faa11375c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.18.1/skarn-aarch64-linux.tar.gz"
      sha256 "9915b1a7c1f30b487845d3f604f81c523ee0c81ad1e41703ac45ae6a928ece40"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.18.1/skarn-x86_64-linux.tar.gz"
      sha256 "c1ed7e3318a8e209f693d023edf10432656d4391b715f59767bbe35c335e27ef"
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
