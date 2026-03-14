class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.0.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.8/osc-record_darwin_arm64.tar.gz"
      sha256 "e35dd8c9c63103886e88923b87249b6d535af9e5a472aa6ad8d9cd074e047668"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.8/osc-record_darwin_amd64.tar.gz"
      sha256 "3d8cd7e23c1c4eb8b30cb93ed7687b9d9fc857cadc97b2fb3f10f5cbb087828d"
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
