class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.37.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.37.0/skarn-aarch64-macos.tar.gz"
      sha256 "6a35ff3da15f4505d57c398430f8e5b839d2e5f6e5261d06830e4d36483bdb0e"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.37.0/skarn-x86_64-macos.tar.gz"
      sha256 "2f99a78f44659166117b5a9d1f81672324d2aa96e8f330f8e32a879dd8ecc9e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.37.0/skarn-aarch64-linux.tar.gz"
      sha256 "38586398e9e8e6d97d6200b2e415d7c683b95c216ff63f94a510619dc4f7571c"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.37.0/skarn-x86_64-linux.tar.gz"
      sha256 "cf28519b01cadd765de3ad0afb8a995541c61170a1886a4099ddacc442c7bcf1"
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
