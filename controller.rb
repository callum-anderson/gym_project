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

get '/gym_member' do
  @all_members = GymMember.view_all()
  @all_classes = GymClass.view_all()
  erb :'gym_member/index'
end

get '/gym_class' do
  @all_classes = GymClass.view_all()
  @all_members = GymMember.view_all()
  erb :'gym_class/index'
end

get '/gym_booking' do
  @all_bookings = GymBooking.show_all_bookings()
  erb :'gym_booking/index'
end

get '/gym_member/new' do
  erb :'gym_member/new'
end

get '/gym_class/new' do
  erb :'gym_class/new'
end

post '/addmember' do
  @member = GymMember.new(params)
  @member.save()
  erb(:member_added)
end

post '/addgymclass' do
  @gym_class = GymClass.new(params)
  @gym_class.save()
  erb(:gymclass_added)
end

post '/update_member/:id' do
  @member = GymMember.new(params)
  @member.update()
  @all_members = GymMember.view_all()
  erb(:member_updated)
end

post '/delete_member/:id' do
  @member = GymMember.new(params)
  @member.delete()
  @all_members = GymMember.view_all()
  erb(:member_deleted)
end

post '/update_class/:id' do
  @gym_class = GymClass.new(params)
  @gym_class.update()
  @all_classes = GymClass.view_all()
  erb(:class_updated)
end

post '/delete_class/:id' do
  @gym_class = GymClass.new(params)
  @gym_class.delete()
  @all_classes = GymClass.view_all()
  erb(:class_deleted)
end

post '/add_to_class' do
  @member = GymMember.new(params)
  @gymclass_id = params['gym_class']
  GymClass.add_member_by_id(@gymclass_id, @member.id)
  @all_members = GymMember.view_all()
  @all_classes = GymClass.view_all()
  erb(:member_added_to_class)
end

post '/add_member_to_class' do
  @gymclass_booking = params
  @member = GymMember.object_from_db(params['member'])
  GymClass.add_member_by_id(@gymclass_booking['id'], @member.id)
  @all_members = GymMember.view_all()
  @all_classes = GymClass.view_all()
  erb(:class_member_added)
end

post '/delete_booking/:id' do
  @booking = GymBooking.object_from_db(params['id']).delete()
  @booking_details = {'first_name' => params['first_name'],
                      'last_name' => params['last_name'],
                      'name' => params['name']}
  @all_bookings = GymBooking.show_all_bookings()
  erb(:booking_deleted)
end
