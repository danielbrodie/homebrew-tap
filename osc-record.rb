class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.4/osc-record_darwin_arm64.tar.gz"
      sha256 "897d3e66b7f6fb6d40f1fee86a313d5479c93e67a2ef18a9bc950ed438d82ff5"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.4/osc-record_darwin_amd64.tar.gz"
      sha256 "a7e1a6eed44783d3a4805d6f69336fe086808f50d956e5a97b05733850190e7a"
    end
  end

  depends_on "danielbrodie/tap/ffmpeg-decklink" => :recommended

  def install
    bin.install "osc-record"
  end

  def caveats
    <<~EOS
      Run `osc-record setup` to configure, then `osc-record run` to start.

      Default OSC addresses:
        Record: /start/record/
        Stop:   /stop/record/
        Port:   8000

      For Blackmagic DeckLink capture, Desktop Video drivers are required:
        https://www.blackmagicdesign.com/support

      To reinstall or upgrade:
        brew uninstall osc-record ffmpeg-decklink
        brew untap danielbrodie/tap
        brew tap danielbrodie/tap
        brew install osc-record
    EOS
  end

  test do
    assert_match "osc-record v", shell_output("#{bin}/osc-record version")
  end
end
