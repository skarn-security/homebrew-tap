class Skarn < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.29.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.29.0/skarn-aarch64-macos.tar.gz"
      sha256 "dfceefb4cbf90f4f1ef203dc2dd02d505a761728692ffdd44d72a81fe8edb09f"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.29.0/skarn-x86_64-macos.tar.gz"
      sha256 "d7461e1c1c11a1fcf4e9d8d1ddf9e892e9b3a3292881c61c5d1a0f729b5b8116"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.29.0/skarn-aarch64-linux.tar.gz"
      sha256 "40c208dd784993a289b33eb45b5e8032cdb660bc6087faa82957a492bb729f94"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.29.0/skarn-x86_64-linux.tar.gz"
      sha256 "1fcb441271b4b9fdf623fc2340b52630b25cba6c8da81bc7a6977f442d6f345d"
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
