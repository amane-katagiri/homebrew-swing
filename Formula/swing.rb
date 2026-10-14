class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.8/swing-v0.1.8-aarch64-apple-darwin.tar.gz"
    sha256 "80d2b5647dcb9a60e12163b0efe6e480254be46cf1208873774e659332554dba"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.8/swing-v0.1.8-x86_64-apple-darwin.tar.gz"
    sha256 "ef233a15bd31bfe178e59c7ce61ff28ea0ad8270ba9d8a0d69e36b73128a7a6e"
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

      To check your site with an AI coding agent before publishing it, add the agent skill:
        swing skill install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swing --version")
  end
end
