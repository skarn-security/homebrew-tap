class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.28.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.28.0/skarn-aarch64-macos.tar.gz"
      sha256 "c8d0af21a57f1d8972f77de27c69016ee2341e61ae63fb43398c33bf72643518"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.28.0/skarn-x86_64-macos.tar.gz"
      sha256 "ca67ea498080590287850cb3ad3e9b063de5c67a08ba6221123e529c99c97c2b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.28.0/skarn-aarch64-linux.tar.gz"
      sha256 "7bc1fc89af0233b64c59a48a4d45b593b4a956fa72f2d124ebe979a96bc3eebd"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.28.0/skarn-x86_64-linux.tar.gz"
      sha256 "a2767d51216166a8ff0b629f1d1b447095c3517227cb8eeb2619988aa57951a0"
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
