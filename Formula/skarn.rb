class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.32.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.32.0/skarn-aarch64-macos.tar.gz"
      sha256 "a0f1613f1ab846235c71f1f7e00f90affa6036526d7a513418ef74f9b314d4d7"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.32.0/skarn-x86_64-macos.tar.gz"
      sha256 "73f767844c58c302a0f9089f1cdc22b75004f1da3223d1f6c3de80d6b40c5192"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.32.0/skarn-aarch64-linux.tar.gz"
      sha256 "17abed8c0af6b07f9d1cda414e154f0eee91fcb025ed8189885ec89e80a209c1"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.32.0/skarn-x86_64-linux.tar.gz"
      sha256 "5be2fe5827e6983d55833873169393e8613a299874f63bdbdd1d6ba6915c5ce3"
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
