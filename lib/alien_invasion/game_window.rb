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

    def needs_cursor?
      true
    end

    def update
      @ob.move
    end

    def draw
      self.caption = "#{Gosu::fps} fps - mouse #{mouse_x.round} x #{mouse_y.round}" if ENV['DEVELOPMENT'] == 'true'

      @background_image.draw(0, 0, Z_ORDER)
      @map1.draw
      @ob.draw
    end

    def button_down(key)
      close if key == Gosu::KbEscape

      if ENV['DEVELOPMENT'] == 'true'
        puts "### #{key} key pressed"
        puts "### Clicked - #{mouse_x.round} x #{mouse_y.round}" if key == Gosu::MsLeft
      end
    end
  end
end
