# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "capistrano-stretcher-rails"
  spec.version       = "0.2.0"
  spec.authors       = ["SHIBATA Hiroshi", "Uchio Kondo"]
  spec.email         = ["hsbt@ruby-lang.org", "udzura@udzura.jp"]

  spec.summary       = %q{rails specific tasks for capistrano-stretcher}
  spec.description   = %q{rails specific tasks for capistrano-stretcher}
  spec.homepage      = "https://github.com/pepabo/capistrano-stretcher-rails"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano-stretcher"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
