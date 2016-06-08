lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec-validates_timeliness/version'

Gem::Specification.new do |gem|
  gem.platform      = Gem::Platform::RUBY
  gem.name          = "rspec-validates_timeliness"
  gem.version       = RSpec::ValidatesTimeliness::VERSION
  gem.summary       = %q{Simple RSpec matchers for validates_timeliness}
  gem.description   = %q{Simple RSpec matchers for validates_timeliness}

  gem.required_ruby_version = ">= 2.1.0"

  gem.authors       = ["Yoshiyuki Hirano"]
  gem.email         = ["yhirano@aiming-inc.com"]
  gem.homepage      = "https://github.com/yhirano55/rspec-validates_timeliness"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rspec", ">= 3.0"
  gem.add_dependency "validates_timeliness", "~> 4.0"
  gem.add_dependency "timecop", ">= 0.8.0"
  gem.add_dependency "activesupport",  ">= 4.0"

  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "activemodel", ">= 4.0"
end
