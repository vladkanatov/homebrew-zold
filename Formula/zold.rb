class Zold < Formula
  desc 'Cryptocurrency with no blockchain'
  homepage 'https://zold.io'
  url 'https://rubygems.org/downloads/zold-0.31.10.gem'
  sha256 '9288cabda7563ce02ae3feaf35d88000b430f55b80724098caf76f6188e4e798'
  license 'MIT'

  depends_on "ruby"

  def install
    system "gem", "install", cached_download, "--install-dir", libexec
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    system "#{bin}/zold", "--version"
  end
end
