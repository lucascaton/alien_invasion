module AlienInvasion
  class GameWindow < Gosu::Window
    Z_ORDER = AlienInvasion::GameConfig.z_order(:background)

    def initialize
      config = AlienInvasion::GameConfig
      super(config.width, config.height, fullscreen: config.fullscreen)
      self.caption = config.caption

      @background_image = Gosu::Image.new('images/background.png', tileable: true)

      @map1 = AlienInvasion::Map.new(:map1)
      @ob   = AlienInvasion::Aliens::Ob.new(map: @map1, speed: 3, hp: 10)
    end

    def update
      @ob.move unless @ob.finished?
    end

    def draw
      self.caption = "#{Gosu::fps} fps" if ENV['DEVELOPMENT'] == 'true'

      @background_image.draw(0, 0, Z_ORDER)
      @map1.draw
      @ob.draw unless @ob.finished?
    end

    def button_down(key)
      puts "### #{key} key pressed" if ENV['DEVELOPMENT'] == 'true'
      close if key == Gosu::KbEscape
    end
  end
end
