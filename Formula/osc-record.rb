class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "2.1.0"

  on_macos do
    if Hardware::CPU.arm?
      # v2.1.0 ships the Rust controller (osc-record) and the C++ daemon
      # (osc-recorder) as two tarballs from the same GitHub release.
      # The controller binary keeps the same name as the Go v1.x binary
      # so existing LaunchAgents and shell aliases keep working across
      # the upgrade.
      url "https://github.com/danielbrodie/osc-record/releases/download/v2.1.0/osc-record_darwin_arm64.tar.gz"
      sha256 "6d94d650ea1d537e721551eea1dc16068f812b9726943a99d8b2743f69d1c2d7"

      resource "osc-recorder" do
        url "https://github.com/danielbrodie/osc-record/releases/download/v2.1.0/osc-recorder_darwin_arm64.tar.gz"
        sha256 "df8a69767f8af614974e7e289d0295a807cc26842696fef7065b6775ce71efe0"
      end
    end
  end

  depends_on "ffmpeg"
  depends_on "danielbrodie/tap/ffmpeg-decklink"
  depends_on "danielbrodie/tap/decklink-tools"

  def install
    bin.install "osc-record"
    resource("osc-recorder").stage do
      bin.install "osc-recorder"
    end
  end

  def caveats
    <<~EOS
      v2.1.0 adds external audio source support (audio_source =
      "avfoundation:<id>" — run `osc-record audio-devices` to list
      options) and fixes a locked-signal SDK throttle that silently
      caused v2.0.0 to capture zero frames on OSC-triggered recordings
      after extended idle.

      If you're upgrading from the Go v1.x, see the cutover runbook
      bundled with the source tree:

        osc-record-rs/docs/cutover.md

      Quick check after install:
        osc-record version       # osc-record 2.1.0
        osc-record audio-devices
        osc-recorder --help
    EOS
  end

  test do
    assert_match "osc-record #{version}", shell_output("#{bin}/osc-record version")
    assert_match "usage:", shell_output("#{bin}/osc-recorder --help")
  end
end
