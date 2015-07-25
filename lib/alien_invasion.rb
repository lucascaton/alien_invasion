require File.expand_path('../alien_invasion/game_config', __FILE__)
require File.expand_path('../alien_invasion/map', __FILE__)
require File.expand_path('../alien_invasion/game_window', __FILE__)
Dir['./lib/alien_invasion/aliens/*.rb'].each { |f| require f }

window = AlienInvasion::GameWindow.new
window.show
