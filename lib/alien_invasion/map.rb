module AlienInvasion
  class Map
    TILE_SIZE = 85 # px
    MAP_PATH, MAP_BEGIN, MAP_END = %w(p b e)
    Z_ORDER = AlienInvasion::GameConfig.z_order(:paths)

    def initialize(name)
      @path_image  = Gosu::Image.new('images/path.png', tileable: true)
      @coordinates = generate_coordinates(name)
    end

    def draw
      @coordinates.each { |x, y| @path_image.draw(x, y, Z_ORDER) }
    end

    private

    def generate_coordinates(name)
      width_base  = 0.1 * AlienInvasion::GameConfig.width
      height_base = 0.1 * AlienInvasion::GameConfig.height

      coordinates = []

      map_file = File.read File.expand_path("../maps/#{name}", __FILE__)

      map_file.split.map(&:chars).each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          if column == MAP_PATH
            x = width_base  + (column_index * TILE_SIZE)
            y = height_base + (row_index    * TILE_SIZE)

            if ENV['DEVELOPMENT'] == 'true'
              puts "#{row_index + 1} x #{column_index + 1}\t(#{x.round}px x #{y.round}px)"
            end

            coordinates << [x, y]
          end
        end
      end

      coordinates
    end
  end
end
