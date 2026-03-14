class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.0/osc-record_darwin_arm64.tar.gz"
      sha256 "328cf681da3096a429478d466386cc7be24b12cd436580c38042655e05d3fba9"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.0.0/osc-record_darwin_amd64.tar.gz"
      sha256 "87f2ee4c3401fb5d431ee9cd1b508037485bb76d05b0030e54df387b012e07fe"
    end
  end

  # ffmpeg-decklink is recommended for Blackmagic hardware but not required.
  # Users with an existing ffmpeg install can set ffmpeg.path in config instead.
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
