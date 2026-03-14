class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.0.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.3/osc-record_darwin_arm64.tar.gz"
      sha256 "166aaf3a2006a7456df36e6f2a39e0a3cff360f6b60ec907dbc5527c76440554"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.3/osc-record_darwin_amd64.tar.gz"
      sha256 "473ff94e46c4b97c9261eee371c4443725223ff144930759d5d0c402aaa58209"
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
