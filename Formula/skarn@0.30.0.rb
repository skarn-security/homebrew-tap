class SkarnAT0300 < Formula
  desc "AI session security scanner with built-in session search"
  homepage "https://getskarn.com"
  version "0.30.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.30.0/skarn-aarch64-macos.tar.gz"
      sha256 "88c91b7be15320c27d272e4860f064694c066808b94344fd647bfc27b5dea328"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.30.0/skarn-x86_64-macos.tar.gz"
      sha256 "0261ebad3f8ba3b0244a6406c274b52c1e418d0c24cca8080bb55d249da63c86"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.30.0/skarn-aarch64-linux.tar.gz"
      sha256 "d7027886cf86206708ba59faee729de955eb51c697400b730081c294d6b3386c"
    end
    on_intel do
      url "https://github.com/skarn-security/skarn-dist/releases/download/v0.30.0/skarn-x86_64-linux.tar.gz"
      sha256 "d8e17105d83bdfb617be6f57a27d138cc750f9b7e9d844b67b6f91e0b2662dc0"
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
