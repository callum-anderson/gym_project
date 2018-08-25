require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('db/sql_runner.rb')
require_relative('model/GymMember.rb')
require_relative('model/GymClass.rb')
require_relative('model/GymBooking.rb')
also_reload('model/*')

get '/' do
  erb(:index)
end

get '/allmembers' do
  @all_members = GymMember.view_all()
  erb(:allmembers)
end

get '/allclasses' do
  @all_classes = GymClass.view_all()
  erb(:allclasses)
end

get '/allbookings' do
  @all_bookings = GymBooking.show_all_bookings()
  erb(:allbookings)
end
