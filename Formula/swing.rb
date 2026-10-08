class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.2/swing-v0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "bb0276e788afcf018cbbcbb85da8a273355155d08531ffc0d6a50f5bd858761c"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.2/swing-v0.1.2-x86_64-apple-darwin.tar.gz"
    sha256 "dbc2b9929a125d5b7b547fe2aa72dee4c351b0980800e386d781318d63a91ee6"
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
