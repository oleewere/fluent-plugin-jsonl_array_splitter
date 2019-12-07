# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-jsonl_array_splitter"
  spec.version       = "0.1.0"
  spec.authors       = ["Oliver Szabo"]
  spec.email         = ["oleewere@gmail.com"]
  spec.description   = %q{Fluentd filter plugin to split JSONL fomatted array text into multiple events}
  spec.summary       = %q{Fluentd filter plugin to split JSONL fomatted array text into multiple events}
  spec.homepage      = "https://github.com/oleewere/fluent-plugin-jsonl_array_splitter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
 
  spec.add_runtime_dependency 'fluentd', ['>= 0.14.0', '< 2']

  spec.add_development_dependency "rake",      ["~> 11.0"]
  spec.add_development_dependency 'test-unit', '~> 3.3', '>= 3.3.3'
  spec.add_development_dependency 'test-unit-rr', '~> 1.0', '>= 1.0.5'
end