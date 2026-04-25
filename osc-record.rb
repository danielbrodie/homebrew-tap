class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.5.0"
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.5.0/osc-record_darwin_arm64.tar.gz"
      sha256 "001278802922fef8410abdcef0cb55460780dcad4500fafe30ee7ca06a14998b"
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
