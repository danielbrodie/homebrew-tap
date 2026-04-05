class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.4.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.4.4/osc-record_darwin_arm64.tar.gz"
      sha256 "fd036a91dff06b13748a1f69646a9a00a054f12ea921e9d9c0408ff85756f0ca"
    else
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.4.4/osc-record_darwin_amd64.tar.gz"
      sha256 "515db646830698f366f3dbf4b6eb3eaf96d32139c09b6856a292b494cf7bf7dc
ab57a5111196a10402a33f96eedbf98d087a4dbb137341be54bf6d68b9a61cb7"
    end
  end

  depends_on "ffmpeg"
  depends_on "danielbrodie/tap/ffmpeg-decklink"

  def install
    bin.install "osc-record"
  end

  def caveats
    <<~EOS
      Run \`osc-record setup\` to configure, then \`osc-record run\` to start.

      Default OSC addresses:
        Record: /start/record/
        Stop:   /stop/record/
        Port:   8000

      For Blackmagic DeckLink capture, Desktop Video drivers are required:
        https://www.blackmagicdesign.com/support
    EOS
  end

  test do
    assert_match "osc-record v", shell_output("#{bin}/osc-record version")
  end
end
