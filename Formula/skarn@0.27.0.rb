class SkarnAT0270 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.27.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.27.0/skarn-aarch64-macos.tar.gz"
      sha256 "cee4e20e66d589bd322eade412724b728c57484e3f425f61e9767e122353d435"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.27.0/skarn-x86_64-macos.tar.gz"
      sha256 "b666b3885b947683401ab6c8abc994c9a4e84f522ea5fc92ff46573b200d900a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.27.0/skarn-aarch64-linux.tar.gz"
      sha256 "f142ef087b7d068b0087b48764a1f6524d0653e7d65c5540774967e82d0511e5"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.27.0/skarn-x86_64-linux.tar.gz"
      sha256 "9141c415d19923e9ee4d7f7646fc600a7e0d587fc2b004ba2674f9757a8e88ca"
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
