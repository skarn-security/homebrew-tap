class SkarnAT0220 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.22.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.22.0/skarn-aarch64-macos.tar.gz"
      sha256 "919a5d7a642660e0752287a4faa085467a85b70d52d17a66fff9d7c85bfd3df3"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.22.0/skarn-x86_64-macos.tar.gz"
      sha256 "1c200199d5a5d68d0f068fdb773a8394c0e316e365c502c5271046cf1b388095"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.22.0/skarn-aarch64-linux.tar.gz"
      sha256 "bb0e326d13fb490332107b50256deb98d527fee1835cdfd924514f21019f125e"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.22.0/skarn-x86_64-linux.tar.gz"
      sha256 "eb5ae1a667ee6917b246854e2fcc23c5370ef0712e5db00201ff6e65f1bc4d14"
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
