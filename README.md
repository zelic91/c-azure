# Carrierwave::Azure

Windows Azure blob storage support for [CarrierWave](https://github.com/carrierwaveuploader/carrierwave)
Inspired from [carrierwave-azure](https://github.com/unosk/carrierwave-azure)

## Installation

Add this line to your application's Gemfile:

    gem 'c-azure'

And then execute:

    $ bundle

## Usage

First configure CarrierWave with your Azure storage credentials

see [Azure/azure-storage-ruby](https://github.com/Azure/azure-storage-ruby)

```ruby
CarrierWave.configure do |config|
  config.azure_storage_account_name = 'YOUR STORAGE ACCOUNT NAME'
  config.azure_storage_access_key = 'YOUR STORAGE ACCESS KEY'
  config.azure_storage_blob_host = 'YOUR STORAGE BLOB HOST' # optional
  config.azure_container = 'YOUR CONTAINER NAME'
  config.asset_host = 'YOUR CDN HOST' # optional
end
```

And then in your uploader, set the storage to `:azure`

```ruby
class ExampleUploader < CarrierWave::Uploader::Base
  storage :azure
end
```

## Contributing

In order to run the integration specs you will need to configure some environment variables.
A sample file is provided as `spec/environment.rb.sample`.
Copy it over and plug in the appropriate values.

```bash
cp spec/environment.rb.sample spec/environment.rb
```

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
