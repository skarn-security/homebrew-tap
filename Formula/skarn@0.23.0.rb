class SkarnAT0230 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.23.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.23.0/skarn-aarch64-macos.tar.gz"
      sha256 "0388a0b7238cd2348149eca9b5a070d28cbe72240ef1de6bb7a04f585b0a9a1d"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.23.0/skarn-x86_64-macos.tar.gz"
      sha256 "463a4a326704896b4ac843c48c53437ccc89d8deadcdc7da0717474c5efdb2d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.23.0/skarn-aarch64-linux.tar.gz"
      sha256 "b2e9d486a71aeed7c46519cc3fe5555e33ea2c6c7900da37392307287c18dedf"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.23.0/skarn-x86_64-linux.tar.gz"
      sha256 "addaf64a70b2d6644320b4e0788a3bab96a723ecdbfae82108037c45a81e8116"
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
