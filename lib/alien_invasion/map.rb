module AlienInvasion
  class Map
    TILE_SIZE = 85 # px
    PATHS = { normal: '.', begin: '^', end: '$' }
    IMAGES = PATHS.keys.map { |path| [path, Gosu::Image.new("images/paths/#{path}.png", tileable: true)] }.to_h
    Z_ORDER = AlienInvasion::GameConfig.z_order(:paths)

    def initialize(name)
      @coordinates = generate_coordinates(name)
    end

    def draw
      @coordinates.each { |x, y, path| IMAGES[path].draw(x, y, Z_ORDER) }
    end

    private

    def generate_coordinates(name)
      width_base  = 0.1 * AlienInvasion::GameConfig.width
      height_base = 0.1 * AlienInvasion::GameConfig.height

      coordinates = []

      map_file = File.read File.expand_path("../maps/#{name}", __FILE__)

      map_file.split.map(&:chars).each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          next unless PATHS.values.include?(column)

          x = width_base  + (column_index * TILE_SIZE)
          y = height_base + (row_index    * TILE_SIZE)

          if ENV['DEVELOPMENT'] == 'true'
            puts "#{row_index + 1} x #{column_index + 1}\t(#{x.round}px x #{y.round}px)"
          end

          coordinates << [x, y, PATHS.key(column)]
        end
      end

      coordinates
    end
  end
end
