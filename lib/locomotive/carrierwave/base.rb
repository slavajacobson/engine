module CarrierWave
  module Uploader
    class Base
      process :set_width_and_height

      def set_width_and_height
        
        if file.content_type == "image/jpeg"
          dragonfly_img = Dragonfly.app.fetch_file(file.file)
          model.width, model.height = dragonfly_img.width, dragonfly_img.height
        end
      end

      def to_label
        File.basename(self.to_s, File.extname(self.to_s))
      end

      def to_liquid
        Locomotive::Liquid::Drops::Uploader.new(self)
      end

    end
  end
end
