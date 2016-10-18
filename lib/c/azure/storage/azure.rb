require 'azure/storage'

module C
  module Azure
    module Storage
      class Azure < CarrierWave::Storage::Abstract
        def store!(file)
          azure_file = C::Azure::Storage::Azure::File.new(uploader, connection, uploader.store_path)
          azure_file.store!(file)
          azure_file
        end

        def retrieve!(identifer)
          C::Azure::Storage::Azure::File.new(uploader, connection, uploader.store_path(identifer))
        end

        def connection
          @connection ||= begin
                            client = ::Azure::Storage::Client.create(storage_account_name: uploader.azure_storage_account_name,
                                                                   storage_access_key: uploader.azure_storage_access_key)
                            client.blob_client
                          end
        end

        class File
          attr_reader :path

          def initialize(uploader, connection, path)
            @uploader = uploader
            @connection = connection
            @path = path
          end

          def store!(file)
            @content = file.read
            @content_type = file.content_type
            @connection.create_block_blob @uploader.azure_container, @path, @content, content_type: @content_type
            true
          end

          def url(options = {})
            path = ::File.join @uploader.azure_container, @path
            if @uploader.asset_host
              "#{@uploader.asset_host}/#{path}"
            else
              @connection.generate_uri(path).to_s
            end
          end

          def read
            content
          end

          def content_type
            @content_type = blob.properties[:content_type] if @content_type.nil? && !blob.nil?
            @content_type
          end

          def content_type=(new_content_type)
            @content_type = new_content_type
          end

          def exists?
            blob.nil?
          end

          def size
            blob.properties[:content_length] unless blob.nil?
          end

          def filename
            URI.decode(url).gsub(/.*\/(.*?$)/, '\1')
          end

          def extension
            @path.split('.').last
          end

          def delete
            begin
              @connection.delete_blob @uploader.azure_container, @path
              true
            rescue ::Azure::Storage::Core::StorageError
              false
            end
          end

          private

          def blob
            load_content if @blob.nil?
            @blob
          end

          def content
            load_content if @content.nil?
            @content
          end

          def load_content
            @blob, @content = begin
                                @connection.get_blob @uploader.azure_container, @path
                              rescue ::Azure::Storage::Core::StorageError
                              end
          end
        end
      end
    end
  end
end
