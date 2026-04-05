class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.4.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.4.3/osc-record_darwin_arm64.tar.gz"
      sha256 "e4489dfd7b45b5c1d0d3fc66244d41b64347354cb27cb8c3f889abc8a0abbf97"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.4.3/osc-record_darwin_amd64.tar.gz"
      sha256 "0466585828dc276df42c365a2dcdc68ac364f51753211c54b4e6a71dd512d058"
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
