class SkarnAT0180 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.18.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.18.0/skarn-aarch64-macos.tar.gz"
      sha256 "3a46f1f4d693d0d86f1bbf74b9ec39b610cbc95ed169f1f4e4e48fa8fdf010b0"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.18.0/skarn-x86_64-macos.tar.gz"
      sha256 "bc50c2ae2d1d1fdee2c3f109381cfeb92b88911cb0074092b25be928127ee5bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.18.0/skarn-aarch64-linux.tar.gz"
      sha256 "85ffe6c0bd506ada0f4ff530e2c689f09c115d81a556d8e63cb088010fc3678d"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.18.0/skarn-x86_64-linux.tar.gz"
      sha256 "5af6b3c46a1268711a52bed2c5db9a83af36ed03cf92f4e8670246c21b9b4043"
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
