class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.4.6"
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.4.6/osc-record_darwin_arm64.tar.gz"
      sha256 "97842c48938c7a387b53b811c1a05c8d21389eb3a28c52876987c4dd8bf14404"
    end
  end
  depends_on "ffmpeg"
  depends_on "danielbrodie/tap/ffmpeg-decklink"
  def install
    bin.install "osc-record"
  end
  test do
    assert_match "osc-record v", shell_output("#{bin}/osc-record version")
  end
end
