class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.2.4/osc-record_darwin_arm64.tar.gz"
      sha256 "e18c87c7137e168296c6d45a5e2c6779c3b29cdd57effb913043d72ffad1fe00"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.2.4/osc-record_darwin_amd64.tar.gz"
      sha256 "c8ed6f1dd0f2eb3ce2de5f93091545eb3795bb7529d3380c7b9a33306dfb13e7"
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
