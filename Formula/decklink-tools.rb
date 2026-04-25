class DecklinkTools < Formula
  desc "Native Blackmagic SDK utilities for osc-record (probe + monitor)"
  homepage "https://github.com/danielbrodie/osc-record"
  version "1.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danielbrodie/osc-record/releases/download/v1.6.0/decklink-tools-darwin-arm64.tar.gz"
      sha256 "623fe14d405995f4687dad42e306c0972c60124802d54a2aa0c32111aed52e36"
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
