module AlienInvasion
  class GameWindow < Gosu::Window
    def initialize
      config = AlienInvasion::GameConfig
      super(config.width, config.height, fullscreen: config.fullscreen)
      self.caption = config.caption

      @background_image = Gosu::Image.new('images/background.png', tileable: true)

      @map1 = AlienInvasion::Map.new(:map1)
      @ob = AlienInvasion::Aliens::Ob.new
      @ob.warp(*@map1.get_coordinates(:begin))
    end

    def update
      @ob.move
    end

    def draw
      self.caption = "#{Gosu::fps} fps" if ENV['DEVELOPMENT'] == 'true'

      @background_image.draw(0, 0, AlienInvasion::GameConfig.z_order(:background))

      @map1.draw
      @ob.draw
    end

    def button_down(key)
      puts "### #{key} key pressed" if ENV['DEVELOPMENT'] == 'true'
      close if key == Gosu::KbEscape
    end
  end
end
