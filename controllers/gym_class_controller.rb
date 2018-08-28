require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../model/GymMember.rb')
require_relative('../model/GymClass.rb')
require_relative('../model/GymBooking.rb')
require_relative('../db/sql_runner.rb')
also_reload('../model/*')

get '/gym_class' do
  erb :'gym_class/index', :layout => :gym_class_layout
end

get '/gym_class/new' do
  erb :'gym_class/new'
end

post '/gym_class' do
  @gym_class = GymClass.new(params)
  @gym_class.save()
  erb(:gymclass_added)
end

delete '/gym_class/:id/delete' do
  @gym_class = GymClass.new(params)
  @gym_class.delete()
  erb :'gym_class/gym_class_deleted', :layout => :gym_class_layout
end

put '/gym_class/:id' do
  @gym_class = GymClass.new(params)
  @gym_class.update()
  erb :'gym_class/gym_class_updated', :layout => :gym_class_layout
end
