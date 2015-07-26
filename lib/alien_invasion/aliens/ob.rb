module AlienInvasion
  module Aliens
    class Ob
      Z_ORDER = AlienInvasion::GameConfig.z_order(:aliens)
      IMAGE = Gosu::Image.new('images/aliens/ob.png')

      def initialize(map:, speed:, hp:)
        @path  = map.path.dup
        @speed = speed
        @hp    = hp
        @dead  = false

        @next_tile = @path.shift
        @x, @y = @next_tile[:x], @next_tile[:y]
      end

      def move
        return if @dead

        @x += (@next_tile[:x] - @x).abs > @speed - 1 ? @speed : 1 if @next_tile[:x] > @x
        @x -= (@next_tile[:x] - @x).abs > @speed - 1 ? @speed : 1 if @next_tile[:x] < @x
        @y += (@next_tile[:y] - @y).abs > @speed - 1 ? @speed : 1 if @next_tile[:y] > @y
        @y -= (@next_tile[:y] - @y).abs > @speed - 1 ? @speed : 1 if @next_tile[:y] < @y

        if [@x, @y] == [@next_tile[:x], @next_tile[:y]]
          @next_tile = @path.shift

          if @next_tile.nil?
            # score -= 1
            @dead = true
          end
        end
      end

      def draw
        IMAGE.draw(@x, @y, Z_ORDER) unless @dead
      end
    end
  end
end
