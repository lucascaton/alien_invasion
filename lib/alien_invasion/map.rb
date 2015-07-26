module AlienInvasion
  class Map
    TILE_SIZE = 85 # px
    TILES = { normal: '#', begin: '^', end: '$' }
    IMAGES = TILES.keys.map { |tile| [tile, Gosu::Image.new("images/maps/#{tile}.png", tileable: true)] }.to_h
    Z_ORDER = AlienInvasion::GameConfig.z_order(:map_tiles)

    attr_reader :path

    def initialize(name)
      @tiles = generate_tiles(name)
      @path  = generate_path
    end

    def draw
      @tiles.each { |tile| IMAGES[tile[:type]].draw(tile[:x], tile[:y], Z_ORDER) }
    end

    def find_tile_by_type(type)
      @tiles.find { |tile| tile[:type] == type }
    end

    def find_tile_by_position(row, column)
      @tiles.find { |tile| [tile[:row], tile[:column]] == [row, column] }
    end

    # def find_tile_by_coordinates(x, y)
    # end

    private

    def generate_path
      path = [find_tile_by_type(:begin)]

      while path.last[:type] != :end
        last = path.last

        path << [
          [last[:row] - 1, last[:column]],
          [last[:row] + 1, last[:column]],
          [last[:row],     last[:column] - 1],
          [last[:row],     last[:column] + 1]
        ].map do |row, column|
          next if path.find { |tile| [tile[:row], tile[:column]] == [row, column] }

          find_tile_by_position(row, column)
        end.compact.first
      end

      path
    end

    def generate_tiles(name)
      width_base  = 0.1 * AlienInvasion::GameConfig.width
      height_base = 0.1 * AlienInvasion::GameConfig.height

      tiles = []

      map_file = File.read File.expand_path("../maps/#{name}", __FILE__)

      map_file.split.map(&:chars).each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          next unless TILES.values.include?(column)

          y = (height_base + (row_index    * TILE_SIZE)).round
          x = (width_base  + (column_index * TILE_SIZE)).round

          if ENV['DEVELOPMENT'] == 'true'
            puts "#{row_index + 1} x #{column_index + 1}\t(#{y} x #{x}px)"
          end

          tiles << {
            type:   TILES.key(column),
            row:    row_index    + 1,
            column: column_index + 1,
            y:      y,
            x:      x
          }
        end
      end

      tiles
    end
  end
end
