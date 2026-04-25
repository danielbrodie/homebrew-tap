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
    cd "bin" do
      bin.install "decklink-probe"
      bin.install "decklink-monitor"
    end
  end

  test do
    assert_match "usage:", shell_output("#{bin}/decklink-probe --bogus 2>&1", 1)
  end
end
