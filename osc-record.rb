class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.3.31"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.3.31/osc-record_darwin_arm64.tar.gz"
      sha256 "cab0f72ab206071ef3c12ebcab976dd64447efcbc4903ddf5e7b5d64c9d6fbcf"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.3.31/osc-record_darwin_amd64.tar.gz"
      sha256 "58f6ff54e93f956c58faca692832f6f79de0bfa7b8e81d7fb3d538eb6608ede8"
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

