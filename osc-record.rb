class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.0.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.2/osc-record_darwin_arm64.tar.gz"
      sha256 "5e633bbcb2312b419e2f366372e340841428c5b0a461f52bb21e3f965ba75cfe"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.2/osc-record_darwin_amd64.tar.gz"
      sha256 "cf0b7bce16b3970c925678b760aba66b695184de5255f62526c13239dc828a81"
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
