class Swing < Formula
  desc "Mirror personal static sites between friends over Nostr and IPFS"
  homepage "https://github.com/amane-katagiri/swing"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.7/swing-v0.1.7-aarch64-apple-darwin.tar.gz"
    sha256 "0633d28fdb5d752276eb2404d8b4e7265f2f94c8d9737d4d05a5873dc6a53fce"
  else
    url "https://github.com/amane-katagiri/swing/releases/download/v0.1.7/swing-v0.1.7-x86_64-apple-darwin.tar.gz"
    sha256 "b6738df7e193ba3d6cf839964dac20c55d3f0ddc8ea261df0eda5ea53e872029"
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
