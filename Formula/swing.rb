class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.1/swing-v0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "e7a37438c9d04278f49305ba1dab03ca34cd2e4f80d8d17080c1bfe06ee6e580"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.1/swing-v0.1.1-x86_64-apple-darwin.tar.gz"
    sha256 "9625257c28cd4aa12ed012295eb360da3b1a6725ef3ec36f107d8a0e880ef517"
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
