class SkarnAT0240 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.24.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.24.0/skarn-aarch64-macos.tar.gz"
      sha256 "9f15976ee9ace47eab28d00bf9ed887416768777383fed99100ef2407b503d94"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.24.0/skarn-x86_64-macos.tar.gz"
      sha256 "f1887a9f56f2174bc63e85b4172da51016e910a9083d14cda18c79a088cbe776"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.24.0/skarn-aarch64-linux.tar.gz"
      sha256 "ab81fc0bb1c616b227bdd1067c5a05ca8dc89f25cc416a1817f0d197bfb47ba0"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.24.0/skarn-x86_64-linux.tar.gz"
      sha256 "3c9b7117e93ba0c6ef347173c6c3ccc67cf4655953f2c0a37271e685d8222f8b"
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
