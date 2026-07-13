class SkarnAT0172 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.17.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.2/skarn-aarch64-macos.tar.gz"
      sha256 "63b05b910b7a1cd7ff33c4a8de52d65bd37a73763486789c54005f1eb7bbaec4"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.2/skarn-x86_64-macos.tar.gz"
      sha256 "545b0463966cc90fab26b288d4fb1f1836cbc17fa4ef3898bf3628bc7dcc0adf"
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
