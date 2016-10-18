require 'spec_helper'

describe C::Azure::Storage::Azure::File do
  class TestUploader < CarrierWave::Uploader::Base
    storage :azure
  end

  let(:uploader) { TestUploader.new }
  let(:storage)  { C::Azure::Storage::Azure.new uploader }

  describe '#url' do
    before do
      allow(uploader).to receive(:azure_container).and_return('test')
      allow(uploader).to receive(:azure_account_name).and_return('360uni')
    end

    subject { C::Azure::Storage::Azure::File.new(uploader, storage.connection, 'dummy.txt').url }

    context 'with storage_blob_host' do
      before do
        allow(uploader).to receive(:azure_storage_blob_host).and_return("https://#{uploader.azure_account_name}.blob.core.windows.net")
      end

      it 'should return on asset_host' do
        expect(subject).to eq "#{uploader.azure_storage_blob_host}/test/dummy.txt"
      end
    end

    context 'with asset_host' do
      before do
        allow(uploader).to receive(:asset_host).and_return("https://#{uploader.azure_account_name}.blob.core.windows.net")
      end

      it 'should return on asset_host' do
        expect(subject).to eq "#{uploader.asset_host}/test/dummy.txt"
      end
    end
  end
end
