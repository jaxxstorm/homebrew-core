class HardlinkOsx < Formula
  desc "Command-line utility that implements hardlinks on macOS"
  homepage "https://github.com/selkhateeb/hardlink"
  url "https://github.com/selkhateeb/hardlink/archive/v0.1.1.tar.gz"
  sha256 "5876554e6dafb6627a94670ac33e750a7efeb3a5fbde5ede3e145cdb5131d1ba"

  bottle do
    cellar :any_skip_relocation
    sha256 "65636aa5d94437d15de5242711605a07fe6b3b3eebeb8753120555b2a0efe589" => :mojave
    sha256 "5d1dca9220c4955c4e4a3b05a23f9c241f9ea73a27ac78d967efdaf29f4d9730" => :high_sierra
    sha256 "01a3edbdac1385e04a3b0857e8073f0731ee26f6f71746a9c5347458aafc9623" => :sierra
    sha256 "edf85db2b0586c410dd96f8ab50cf4cc0f34d1494b3b91a5ef0b00ae16fed3c0" => :el_capitan
    sha256 "dcba3e0320ca63d1b958173aa9e2ac24074c5c1f94becaba07f0c92e721b941e" => :yosemite
    sha256 "2ebdf76a67f7c63614d581963d92d79de15cf834b7e3857c139f474db71aab73" => :mavericks
  end

  def install
    system "make"
    bin.mkdir
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats
    <<~EOS
      Hardlinks can not be created under the same directory root. If you try to
      `hln source directory` to target directory under the same root you will get an error!

      Also, remember the binary is named `hln` due to a naming conflict.
    EOS
  end

  test do
    mkdir_p "test1/inner"
    touch "test1/inner/file"
    mkdir "otherdir"
    system "#{bin}/hln", "test1", "otherdir/test2"
    assert File.directory? "otherdir/test2"
    assert File.directory? "otherdir/test2/inner"
    assert File.file? "otherdir/test2/inner/file"
  end
end
