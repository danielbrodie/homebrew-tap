class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "2.2.0"

  on_macos do
    if Hardware::CPU.arm?
      # v2.2.0 ships the Rust controller (osc-record) and the C++ daemon
      # (osc-recorder) as two tarballs from the same GitHub release.
      # The controller binary keeps the same name as the Go v1.x binary
      # so existing LaunchAgents and shell aliases keep working across
      # the upgrade.
      url "https://github.com/danielbrodie/osc-record/releases/download/v2.2.0/osc-record_darwin_arm64.tar.gz"
      sha256 "c0f30a3c7d0867d8c51982fd7d1babdcfd39fd0b583ae94e81ca918a745d3993"

      resource "osc-recorder" do
        url "https://github.com/danielbrodie/osc-record/releases/download/v2.2.0/osc-recorder_darwin_arm64.tar.gz"
        sha256 "184287a2127b28e5970b3bfe7920220e04e69f59ef102e2f39999ab404ea2cdc"
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
      v2.2.0 adds the slate CLI surface (`osc-record slate get/set/
      reset-take`) and matching HTTP endpoints, plus an
      `encoder_stalled` event that pages on permanent ffmpeg writer
      give-up. Encoder writers prewarm a buffer pool so the SDK
      callback thread no longer mallocs per frame at 1080p30.

      Quick check after install:
        osc-record version       # osc-record 2.2.0
        osc-record slate get
        osc-record audio-devices
        osc-recorder --help

      If you're upgrading from the Go v1.x, see the cutover runbook
      bundled with the source tree:

        osc-record-rs/docs/cutover.md
    EOS
  end

  test do
    assert_match "osc-record #{version}", shell_output("#{bin}/osc-record version")
    # osc-recorder's argument parser exits 1 on any flag it doesn't
    # recognize (including --help), but prints the usage banner first.
    # Pass the expected exit code so the assertion matches the binary's
    # actual contract instead of a generic "must exit 0".
    assert_match "usage:", shell_output("#{bin}/osc-recorder --help 2>&1", 1)
  end
end
