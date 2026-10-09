class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.4/swing-v0.1.4-aarch64-apple-darwin.tar.gz"
    sha256 "f0786eb817e0d588da4c001895db780f06204db9fa0d52db2852cfa70dd0ea21"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.4/swing-v0.1.4-x86_64-apple-darwin.tar.gz"
    sha256 "d0c6b3aed9a3ac4915945b0c1e0ef1f53d1143d32f9647b85a0d1a2f5b7ef9fb"
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
