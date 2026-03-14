class FfmpegDecklink < Formula
  desc "Pre-built ffmpeg with Blackmagic DeckLink capture support"
  homepage "https://github.com/danielbrodie/ffmpeg-decklink"
  version "1.0.0"
  license "GPL-2.0-or-later"

  on_arm do
    url "https://github.com/danielbrodie/ffmpeg-decklink/releases/download/v1.0.0/ffmpeg-decklink-darwin-arm64.tar.gz"
    sha256 "0304eeab9281522dd7e34caa11bcb30848730beef2585292b4f87e5bdd817763"
  end

  # Runtime dylib dependencies (linked at build time)
  depends_on "libxcb"
  depends_on "x264"
  depends_on "x265"
  depends_on "libx11"
  depends_on "xz"

  conflicts_with "ffmpeg", because: "both supply an ffmpeg binary (install as ffmpeg-decklink)"

  def install
    bin.install "bin/ffmpeg-decklink"
    bin.install "bin/ffprobe-decklink" if File.exist?("bin/ffprobe-decklink")
  end

  def caveats
    <<~EOS
      ffmpeg-decklink is installed as `ffmpeg-decklink` (not `ffmpeg`).
      It will not conflict with a standard ffmpeg installation.

      To use with osc-record, set in your config.toml:
        [ffmpeg]
        path = "#{opt_bin}/ffmpeg-decklink"

      Or set FFMPEG_PATH in your environment:
        export FFMPEG_PATH="#{opt_bin}/ffmpeg-decklink"

      This binary requires Blackmagic Desktop Video drivers to be installed.
      Download from: https://www.blackmagicdesign.com/support/
    EOS
  end

  test do
    system "#{bin}/ffmpeg-decklink", "-version"
  end
end
