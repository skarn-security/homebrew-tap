class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.17.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.2/skarn-aarch64-macos.tar.gz"
      sha256 "594af63ef47640a88dfb863bca02c1951374b430e8059d8b7556838c62fb634e"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.2/skarn-x86_64-macos.tar.gz"
      sha256 "139ac9609a76d811dd566f3138d048bd1a0839730e5a321cbddbdb06eacf5ef8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.2/skarn-aarch64-linux.tar.gz"
      sha256 "ca943abfa0ccc9924567a2c7ea6ce196b79e75e2a34223119648ec7fbdf76a85"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.2/skarn-x86_64-linux.tar.gz"
      sha256 "8f0223cd6b7e350849237850848049cb1a6c812a10273b2047ad0205a6867f03"
    end
  end

  def install
    bin.install "skarn"
    generate_completions_from_executable(bin/"skarn", "completion")
    man1.install Dir["skarn*.1"]
    doc.install "EULA.md", "EULA-FREE.md", "THIRD-PARTY-NOTICES.md", "EDITIONS.md"
  end

  def caveats
    <<~EOS
      Get started:
        1. Scan this machine:        skarn assess
        2. Install your license:     skarn license ~/Downloads/<your>.skarnlicense
        3. Wire the AI-agent guard:  skarn setup
        4. Verify it's working:      skarn doctor

      The core scan is free and needs no license.
      License status:  skarn license
      Manual:          man skarn
    EOS
  end

  test do
    assert_match "skarn #{version}", shell_output("#{bin}/skarn --version")
  end
end
