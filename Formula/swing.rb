class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.3/swing-v0.1.3-aarch64-apple-darwin.tar.gz"
    sha256 "f44160d57ccf5169367afb326e021635baab0bd1ca5b7d911f56e214bb1c240a"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.3/swing-v0.1.3-x86_64-apple-darwin.tar.gz"
    sha256 "664425ae2fe800729842bc8616981e24a79a4fab7ac912d4d7d5e3f8d1be36b4"
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
