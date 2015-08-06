module Locomotive
  module Liquid
    module Drops
      class Uploader < Base

        delegate :size, :width, :height, to: :@_source

        def url
          url, timestamp = @_source.url, @_source.model.updated_at.to_i

          @context.registers[:asset_host].compute(url, timestamp)
        end

        def filename
          File.basename(@_source.url)
        end
        def width
          Dragonfly.app.fetch_file(@_source.path).width


        end
        def height
          Dragonfly.app.fetch_file(@_source.path).height
        end
      end
    end
  end
end