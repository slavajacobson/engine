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
          if @_source.model.has_attribute?(:width)
            @_source.model.width || set_width
          end
        end

        def height
          if @_source.model.has_attribute?(:height)
            @_source.model.height || set_height
          end
        end

        def set_width
          dragonfly_img = Dragonfly.app.fetch_file(@_source.file.file)
          @_source.model.width = dragonfly_img.width
          @_source.model.save

          dragonfly_img.width
        end

        def set_height

          dragonfly_img = Dragonfly.app.fetch_file(@_source.file.file)
          @_source.model.height = dragonfly_img.height
          @_source.model.save

          dragonfly_img.height
        end
      end
    end
  end
end