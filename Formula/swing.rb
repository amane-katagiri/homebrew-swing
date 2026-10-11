class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.5/swing-v0.1.5-aarch64-apple-darwin.tar.gz"
    sha256 "9d3fc70bd8ae62c93d164e7137b6c6307b4cc2a2f4574663c82fee025f41dd20"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.5/swing-v0.1.5-x86_64-apple-darwin.tar.gz"
    sha256 "f1bc4fdaa5a2d7b30fb52259acf97aba622f06e6445674a43c95afd1fc1704e2"
  end

  depends_on "kubo"
  depends_on :macos

  def install
    libexec.install "swing", "SWING.app"
    bin.write_exec_script opt_libexec/"swing"
    pkgshare.install "swing.example.toml"
  end

  def caveats
    <<~EOS
      Register swing and its menu bar icon to start at login, then open the dashboard:
        swing service install
        swing dashboard open

      Settings and data live in ~/Library/Application Support/swing, logs in ~/Library/Logs/swing.log.

      After `brew upgrade swing`, run `swing service install` again to restart on the new version.
      `brew uninstall swing` leaves the login items and data behind; run `swing service uninstall` first.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swing --version")
  end
end
