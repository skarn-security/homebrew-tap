class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.36.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.36.0/skarn-aarch64-macos.tar.gz"
      sha256 "af56d4381cf24542bfadaeda47e74be2b0c5d9689e6121a5ea1fb92bbd6026c6"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.36.0/skarn-x86_64-macos.tar.gz"
      sha256 "51cf6542c654c6e0a6c26eeafca49e09db8ba08c5a076eba41f4ff8037477a3b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.36.0/skarn-aarch64-linux.tar.gz"
      sha256 "ea4509fd21c55f7f45c34c091a97b726976d9d9d4e35d75c95b4800e72734aa5"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.36.0/skarn-x86_64-linux.tar.gz"
      sha256 "2b1d6ca497d181c78137957948b0718797fb31580453586af323a94c145ebec0"
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
