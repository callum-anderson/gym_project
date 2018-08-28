require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('controllers/gym_member_controller.rb')
require_relative('controllers/gym_class_controller.rb')
require_relative('controllers/gym_booking_controller.rb')

get '/' do
  erb( :index )
end
