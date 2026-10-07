class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.0/swing-v0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "b7471c7576613717fee296295aa55b1a870b81ae89e22729db4abb7063bfdf6c"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.0/swing-v0.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "45dfa177a4c30e5bb27928734202294d56f10f0ed7d16ba5712b230ae7494a65"
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
