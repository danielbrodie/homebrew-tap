class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.1.2/osc-record_darwin_arm64.tar.gz"
      sha256 "557b894edf5ec407ce3aa286e63e4d31b81d4e2d3acc7db9ee4f9a37470a84f0"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.1.2/osc-record_darwin_amd64.tar.gz"
      sha256 "2b3655f49f2b97f1ffc6bee81d4e0d7685e12cf7545e08d4be43fe57e23ae632"
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
