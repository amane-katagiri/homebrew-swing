class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.6/swing-v0.1.6-aarch64-apple-darwin.tar.gz"
    sha256 "126c3ebbab94a1b606cc6d554da16178fc171fcf6a241f4d2b1ff834c2461b7c"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.6/swing-v0.1.6-x86_64-apple-darwin.tar.gz"
    sha256 "58aac1b6283bef9bce073e2c3c3bf0ef2eb9dccac6ce8cd7c1feaa5eef2f6b4a"
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
