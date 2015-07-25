module AlienInvasion
  class GameConfig
    class << self
      def caption
        'Alien Invasion'
      end

      def width
        1920
      end

      def height
        1080
      end

      def fullscreen
        ENV['DEVELOPMENT'] != 'true'
      end

      def z_order(element)
        elements = %i(background aliens)
        elements.index(element)
      end
    end
  end
end
