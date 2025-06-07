class Zold < Formula
  desc 'Cryptocurrency with no blockchain'
  homepage 'https://zold.io'
  url 'https://rubygems.org/downloads/zold-0.31.10.gem'
  sha256 '9288cabda7563ce02ae3feaf35d88000b430f55b80724098caf76f6188e4e798'
  license 'MIT'

  depends_on 'rbenv'
  depends_on 'ruby-build'
  depends_on 'openssl@3'

  def install
    ENV['RBENV_ROOT'] = "#{HOMEBREW_PREFIX}/var/rbenv"
    ENV.prepend_path 'PATH', "#{ENV.fetch('RBENV_ROOT', nil)}/bin"
    system 'rbenv', 'init', '-'

    ruby_version = '3.3.6'
    system 'rbenv', 'install', '--skip-existing', ruby_version
    system 'rbenv', 'global', ruby_version

    openssl_prefix = Formula['openssl@3'].opt_prefix

    ENV['LDFLAGS'] = "-L#{openssl_prefix}/lib"
    ENV['CPPFLAGS'] = "-I#{openssl_prefix}/include"

    system 'gem', 'install', cached_download,
      '--no-document',
      '--',
      "--with-cppflags=-I#{openssl_prefix}/include",
      "--with-ldflags=-L#{openssl_prefix}/lib"

    bin_path = Utils.safe_popen_read('ruby', '-e', 'puts Gem.bindir').chomp
    (bin / 'zold').write_env_script "#{bin_path}/zold", {
      PATH: "#{ENV.fetch('RBENV_ROOT', nil)}/shims:$PATH"
    }
  end

  test do
    system "#{bin}/zold", '--version'
  end
end

