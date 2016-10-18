lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'c/azure/blob/version'

Gem::Specification.new do |gem|
  gem.name          = 'c-azure'
  gem.version       = C::Azure::Blob::VERSION
  gem.authors       = ['Thuong Nguyen']
  gem.email         = ['thuongnh.uit@gmail.com']
  gem.summary       = %q{Microsoft Azure blob storage support for CarrierWave}
  gem.description   = %q{Allows file upload to Azure with the official sdk}
  gem.homepage      = 'https://github.com/zelic91/carrierwave-azure'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^rspec})
  gem.require_paths = ['lib']

  gem.add_dependency 'carrierwave'
  gem.add_dependency 'azure-storage'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3'
end
