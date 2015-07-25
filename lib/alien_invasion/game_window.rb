module AlienInvasion
  class GameWindow < Gosu::Window
    def initialize
      config = AlienInvasion::GameConfig
      super(config.width, config.height, fullscreen: config.fullscreen)
      self.caption = config.caption

      @background_image = Gosu::Image.new('images/background.jpg', tileable: true)

      @green = AlienInvasion::Aliens::Green.new
      @green.warp(320, 240)
    end

    def update
      @green.turn_left  if Gosu::button_down? Gosu::KbLeft
      @green.turn_right if Gosu::button_down? Gosu::KbRight
      @green.accelerate if Gosu::button_down? Gosu::KbUp

      @green.move
    end

    def draw
      self.caption = "#{Gosu::fps} fps" if ENV['DEVELOPMENT'] == 'true'

      @background_image.draw(0, 0, 0)
      @green.draw
    end

    def button_down(key)
      puts "### #{key} key pressed" if ENV['DEVELOPMENT'] == 'true'
      close if key == Gosu::KbEscape
    end
  end
end
