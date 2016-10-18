require 'carrierwave'
require 'c/azure/blob/version'
require 'c/azure/storage/azure'

class CarrierWave::Uploader::Base
  add_config :azure_storage_account_name
  add_config :azure_storage_access_key
  add_config :azure_storage_blob_host
  add_config :azure_container

  configure do |config|
    config.storage_engines[:azure] = 'C::Azure::Storage::Azure'
  end
end
