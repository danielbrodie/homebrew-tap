class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.3.11/osc-record_darwin_arm64.tar.gz"
      sha256 "a35257949cdc7f835231f935fe02995034ec82483cbdeb0aecf619765715501f"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.3.11/osc-record_darwin_amd64.tar.gz"
      sha256 "ee40c7f10be004c869e2a07fa348ce35b605facb268f13bd8b53b67ef3bb6093"
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

