class FfmpegDecklink < Formula
  desc "Pre-built ffmpeg with Blackmagic DeckLink capture support"
  homepage "https://github.com/danielbrodie/ffmpeg-decklink"
  version "1.0.0"
  license "GPL-2.0-or-later"

  on_arm do
    url "https://github.com/danielbrodie/ffmpeg-decklink/releases/download/v1.0.0/ffmpeg-decklink-darwin-arm64.tar.gz"
    sha256 "d3e9e4fa6a7334e6df125a42c72638e1d740b727c7bd56cf8f0b30357cc45bb6"
  end

  # Runtime dylib dependencies (linked at build time)
  depends_on "libxcb"
  depends_on "x264"
  depends_on "x265"
  depends_on "libx11"
  depends_on "xz"

  def install
    bin.install "bin/ffmpeg-decklink"
    bin.install "bin/ffprobe-decklink" if File.exist?("bin/ffprobe-decklink")
  end

  def caveats
    <<~EOS
      ffmpeg-decklink is installed alongside any existing ffmpeg.

      osc-record will auto-detect it. To use explicitly, set in config.toml:
        [ffmpeg]
        path = "#{opt_bin}/ffmpeg-decklink"

      Requires Blackmagic Desktop Video drivers:
        https://www.blackmagicdesign.com/support/
    EOS
  end

  test do
    system "#{bin}/ffmpeg-decklink", "-version"
  end
end
