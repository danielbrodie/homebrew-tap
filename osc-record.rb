class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.3.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.3.12/osc-record_darwin_arm64.tar.gz"
      sha256 "be32a33bba6eb3058eb803d9437ea5c7d384da366c1b8e6c95dd213d7535f406"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.3.12/osc-record_darwin_amd64.tar.gz"
      sha256 "3cc895f1c31d43e4caa5a116e5a92a5251891b06f91d46aa94bd29f4b372a09f"
    end
  end

  depends_on "ffmpeg"
  depends_on "danielbrodie/tap/ffmpeg-decklink"

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

      To use an external audio source (Dante, line-in) with a DeckLink device,
      set `audio` in your device config, or select it during `osc-record setup`.
      Leave blank to use DeckLink embedded audio (default).

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

