module AlienInvasion
  class Map
    TILE_SIZE = 85 # px
    PATHS = { normal: '#', begin: '^', end: '$' }
    IMAGES = PATHS.keys.map { |path| [path, Gosu::Image.new("images/paths/#{path}.png", tileable: true)] }.to_h
    Z_ORDER = AlienInvasion::GameConfig.z_order(:paths)

    def initialize(name)
      @tiles = generate_tiles(name)
    end

    def draw
      @tiles.each { |tile| IMAGES[tile[:type]].draw(tile[:x], tile[:y], Z_ORDER) }
    end

    def tile(tile_type)
      @tiles.find { |tile| tile[:type] == tile_type }
    end

    private

    def generate_tiles(name)
      width_base  = 0.1 * AlienInvasion::GameConfig.width
      height_base = 0.1 * AlienInvasion::GameConfig.height

      tiles = []

      map_file = File.read File.expand_path("../maps/#{name}", __FILE__)

      map_file.split.map(&:chars).each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          next unless PATHS.values.include?(column)

          x = (width_base  + (column_index * TILE_SIZE)).round
          y = (height_base + (row_index    * TILE_SIZE)).round

          if ENV['DEVELOPMENT'] == 'true'
            puts "#{column_index + 1} x #{row_index + 1}\t(#{x} x #{y}px)"
          end

          tiles << {
            type: PATHS.key(column),
            column: column_index,
            row: row_index,
            x: x,
            y: y
          }
        end
      end

      tiles
    end
  end
end
