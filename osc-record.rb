class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v0.2.0/osc-record_darwin_arm64.tar.gz"
      sha256 "PLACEHOLDER_ARM64"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v0.2.0/osc-record_darwin_amd64.tar.gz"
      sha256 "PLACEHOLDER_AMD64"
    end
  end

  depends_on "danielbrodie/tap/ffmpeg-decklink"

  def install
    bin.install "osc-record"
  end

  def caveats
    <<~EOS
      ffmpeg-decklink is installed as a dependency and available at:
        #{Formula["danielbrodie/tap/ffmpeg-decklink"].opt_bin}/ffmpeg-decklink

      osc-record will find it automatically. You can also set:
        export FFMPEG_PATH="#{Formula["danielbrodie/tap/ffmpeg-decklink"].opt_bin}/ffmpeg-decklink"

      You need the Blackmagic Desktop Video drivers installed:
        https://www.blackmagicdesign.com/support

      Quick start:
        osc-record setup   # configure device, OSC addresses, output dir
        osc-record run     # start the TUI daemon
    EOS
  end

  test do
    assert_match "osc-record v", shell_output("#{bin}/osc-record version")
  end
end
