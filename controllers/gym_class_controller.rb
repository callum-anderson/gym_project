require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('model/GymMember.rb')
require_relative('model/GymClass.rb')
require_relative('model/GymBooking.rb')
also_reload('model/*')

get '/gym_class' do
  @all_classes = GymClass.view_all()
  @all_members = GymMember.view_all()
  erb :'gym_class/index', :layout => :gym_class_layout
end

get '/gym_class/new' do
  @all_classes = GymClass.view_all()
  @all_members = GymMember.view_all()
  erb :'gym_class/new'
end

post '/gym_class' do
  @gym_class = GymClass.new(params)
  @gym_class.save()
  erb(:gymclass_added)
end

post '/gym_class/:id/delete' do
  @gym_class = GymClass.new(params)
  @gym_class.delete()
  @all_members = GymMember.view_all()
  @all_classes = GymClass.view_all()
  erb :'gym_class/gym_class_deleted', :layout => :gym_class_layout
end
