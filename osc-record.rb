class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.1/osc-record_darwin_arm64.tar.gz"
      sha256 "72fcf7d5489f0d3f56ab338f134363138eebb3c94eec9ee4d3a542396cf129bc"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.1/osc-record_darwin_amd64.tar.gz"
      sha256 "6f56d0c77bff205d454fb520671a2c30747371e7fe6ccdee1068b2f0d00536e6"
    end
  end

  depends_on "danielbrodie/tap/ffmpeg-decklink" => :recommended

  def install
    bin.install "osc-record"
  end

  def caveats
    <<~EOS
      Default OSC addresses:
        Record: /start/record/
        Stop:   /stop/record/
        Port:   8000

      For Blackmagic DeckLink capture, Desktop Video drivers are required:
        https://www.blackmagicdesign.com/support

      If you already have ffmpeg installed and want to use it instead of
      ffmpeg-decklink, set the path in ~/.config/osc-record/config.toml:
        [ffmpeg]
        path = "/opt/homebrew/bin/ffmpeg"

      Run `osc-record setup` to configure interactively.
    EOS
  end

  test do
    assert_match "osc-record v", shell_output("#{bin}/osc-record version")
  end
end
