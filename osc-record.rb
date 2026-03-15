class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.1.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.1.5/osc-record_darwin_arm64.tar.gz"
      sha256 "81ef848e7d1e55a81770ec340efedc5a3a908cb6b5cd49fabc7a4372272d694c"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.1.5/osc-record_darwin_amd64.tar.gz"
      sha256 "0792df8599bf736d78bbc246802f1dc7dcbd1469f249c984d8b8d7f8c9a61f22"
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
