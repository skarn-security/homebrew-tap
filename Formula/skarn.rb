class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://github.com/skarn-security/skarn"
  version "0.17.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.0/skarn-aarch64-macos.tar.gz"
      sha256 "6d66b3eab75171ba1b5f798827515786881227ed0e58d761c564a7eec3103fc7"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.0/skarn-x86_64-macos.tar.gz"
      sha256 "327e905181ba6043b2de6c6de2e6b611410757ac07c30a26c6718593c97967c6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.0/skarn-aarch64-linux.tar.gz"
      sha256 "c8fbad218304be2c1fe46e2c7eae1df9e16a621989d454d252e5be4691b97f26"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.17.0/skarn-x86_64-linux.tar.gz"
      sha256 "1fb0ccaf2e1ac1fda8351e8e0e7890af111c5702bab28ddca3aaa9ac865fe132"
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
        3. Wire the AI-agent guard:  man skarn-guard
                                     https://github.com/skarn-security/skarn/tree/main/integrations

      The core scan is free and needs no license.
      License status:  skarn license
      Manual:          man skarn
    EOS
  end

  test do
    assert_match "skarn #{version}", shell_output("#{bin}/skarn --version")
  end
end
