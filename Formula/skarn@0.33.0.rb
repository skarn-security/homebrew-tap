class SkarnAT0330 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.33.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.33.0/skarn-aarch64-macos.tar.gz"
      sha256 "d802be77f53b498be283526af9156374a58888baef001653a2273baf9198dbb9"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.33.0/skarn-x86_64-macos.tar.gz"
      sha256 "8ec225aee8d408a5b49f1c45bd853aeef4ea9ada0e3cd45c502758e85ba2b97c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.33.0/skarn-aarch64-linux.tar.gz"
      sha256 "604b53abdbc489b7db49b7d154e65e83ab8e11d7c8f8a284b1c708cd01444c19"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.33.0/skarn-x86_64-linux.tar.gz"
      sha256 "66efe8294049b23a55950c93616f6c21758edcf409857d5383cc95954495a857"
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
