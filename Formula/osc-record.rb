class OscRecord < Formula
  desc "OSC-triggered video capture for live production"
  homepage "https://github.com/danielbrodie/osc-record"
  version "2.0.0"

  on_macos do
    if Hardware::CPU.arm?
      # v2.0.0 ships the Rust controller (osc-record) and the C++ daemon
      # (osc-recorder) as two tarballs from the same GitHub release.
      # The controller binary keeps the same name as the Go v1.x binary
      # so existing LaunchAgents and shell aliases keep working across
      # the upgrade.
      url "https://github.com/danielbrodie/osc-record/releases/download/v2.0.0/osc-record_darwin_arm64.tar.gz"
      sha256 "8b162248bbd9e085080a3b9f22cae1cb2d1b9ff99bbc7a80f07d133827d51497"

      resource "osc-recorder" do
        url "https://github.com/danielbrodie/osc-record/releases/download/v2.0.0/osc-recorder_darwin_arm64.tar.gz"
        sha256 "8a80e8ced80ab87544702927cf160781da997c4b6050b468e15aebac752377be"
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
      v2.0.0 replaces the Go osc-record with a Rust controller of the
      same name plus a new C++ daemon (osc-recorder) for DeckLink
      capture. If you're upgrading a running production node, see the
      cutover runbook bundled with the source tree:

        osc-record-rs/docs/cutover.md

      Quick check after install:
        osc-record version       # osc-record 2.0.0
        osc-recorder --help
    EOS
  end

  test do
    assert_match "osc-record 2.0.0", shell_output("#{bin}/osc-record version")
    assert_match "usage:", shell_output("#{bin}/osc-recorder --help")
  end
end
