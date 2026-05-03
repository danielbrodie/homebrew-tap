class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "2.3.1"

  on_macos do
    if Hardware::CPU.arm?
      # Rust controller (osc-record) and C++ daemon (osc-recorder) ship
      # as two tarballs from the same GitHub release. The controller
      # binary keeps the same name as the Go v1.x binary so existing
      # LaunchAgents and shell aliases keep working across the upgrade.
      url "https://github.com/danielbrodie/osc-record/releases/download/v2.3.1/osc-record_darwin_arm64.tar.gz"
      sha256 "21d177d077bfe8c39b943279ee7110636ae28adf00ebd4e94665eb81ed870a27"

      resource "osc-recorder" do
        url "https://github.com/danielbrodie/osc-record/releases/download/v2.3.1/osc-recorder_darwin_arm64.tar.gz"
        sha256 "d76c562ec77e2bc393469230ce4c3e057fb436484324acb67a9a9012f535f4c8"
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
      v2.2.x adds the slate CLI surface (`osc-record slate get/set/
      reset-take`) and matching HTTP endpoints, plus an
      `encoder_stalled` event that pages on permanent ffmpeg writer
      give-up. Encoder writers prewarm a buffer pool so the SDK
      callback thread no longer mallocs per frame at 1080p30.

      v2.2.1 fixes the setup wizard: it now tolerates a v1 config on
      disk and auto-fills sensible defaults so `osc-record setup
      --non-interactive` succeeds with zero flags on a brew install.

      Quick check after install:
        osc-record version       # osc-record 2.3.1
        osc-record setup         # one-time on a fresh install / v1 → v2 upgrade
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
