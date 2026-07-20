class SkarnAT0190 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.19.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.19.0/skarn-aarch64-macos.tar.gz"
      sha256 "8e779f61b259650599004a8797c445c0a16ee36769b5e4ae5943e0ca25cc83c0"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.19.0/skarn-x86_64-macos.tar.gz"
      sha256 "a89ae2eb7585825ea53853826cfad133def5c9838cacf86ee66b6317538d9c24"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.19.0/skarn-aarch64-linux.tar.gz"
      sha256 "09dcab3797e9484f47b518e5d52290c75fb1fdd2d192c1fbb2693c3c8011ba69"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.19.0/skarn-x86_64-linux.tar.gz"
      sha256 "2ea0aaaff73981d636697c552ddaef5183ffd98a19c1d238d52910cbd2d70a3d"
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
