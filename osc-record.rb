class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.1.1/osc-record_darwin_arm64.tar.gz"
      sha256 "8c5ec84f475b964aeb9d1df5b687e7695f897d35314ec3c4f13cbf726b191b89"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.1.1/osc-record_darwin_amd64.tar.gz"
      sha256 "c4ed97c9346b8d6c0ec8d7abc56b0c8e4cfc41e4967904c4dc652e83c3e886e1"
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
