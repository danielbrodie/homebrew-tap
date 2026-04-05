class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.4.5"
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.4.5/osc-record_darwin_arm64.tar.gz"
      sha256 "0ec0f06ca175aadbea8a5090be9b133cd752798e81e1b994d09055ab642e7f52"
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
