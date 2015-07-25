module AlienInvasion
  module Aliens
    class Ob
      def initialize(speed: 1, hp: 100)
        @image = Gosu::Image.new('images/aliens/ob.png')
        @speed = speed
        @hp    = hp

        @x = @y = 0.0
      end

      def warp(x, y)
        @x, @y = x, y
      end

      def move
        @x += @speed
        @y += @speed
      end

      def draw
        @image.draw(@x, @y, AlienInvasion::GameConfig.z_order(:aliens))
      end
    end
  end
end
