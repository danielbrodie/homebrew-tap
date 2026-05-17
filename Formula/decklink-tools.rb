class DecklinkTools < Formula
  desc "Native Blackmagic SDK utilities for osc-record (probe + monitor)"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record-bin/releases/download/decklink-tools-v1.8.0/decklink-tools-darwin-arm64.tar.gz"
      sha256 "0369b44d6f65d5e018078e044b246842d1bfa12eb0cd2770567b712cdd463098"
    end
  end

  def install
    # The tarball is created via "tar czf -C OUTDIR bin", so brew strip-prefix
    # lands us inside the bin/ directory itself.
    bin.install "decklink-probe", "decklink-monitor"
  end

  def caveats
    <<~EOS
      decklink-probe — one-shot SDK status snapshot (used by osc-record)
      decklink-monitor — long-running event-driven status logger
      Both require Blackmagic Desktop Video drivers.
    EOS
  end

  test do
    assert_match "usage:", shell_output("#{bin}/decklink-probe --bogus 2>&1", 1)
  end
end
