class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.3.0/osc-record_darwin_arm64.tar.gz"
      sha256 "e473d5ccb8eb8df5b3c6ab4a3bc38ff61d5c0bcf31454fe87e1ba9ee44c4e9f3"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.3.0/osc-record_darwin_amd64.tar.gz"
      sha256 "8b4ec0706dd20d5090045b770ed1585b72215e74e179301a599c59fd4dd665a4"
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
