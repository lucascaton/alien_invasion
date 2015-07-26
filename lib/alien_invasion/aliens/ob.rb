module AlienInvasion
  module Aliens
    class Ob
      Z_ORDER = AlienInvasion::GameConfig.z_order(:aliens)
      IMAGE = Gosu::Image.new('images/aliens/ob.png')

      def initialize(map:, speed:, hp:)
        @map   = map
        @speed = speed
        @hp    = hp

        @x, @y = @map.get_coordinates(:begin)
      end

      def move
        @x += @speed
        @y += @speed
      end

      def draw
        IMAGE.draw(@x, @y, Z_ORDER)
      end
    end
  end
end
