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
  @all_classes = GymClass.view_all()
  erb(:all_members)
end

get '/allclasses' do
  @all_classes = GymClass.view_all()
  @all_members = GymMember.view_all()
  erb(:all_classes)
end

get '/allbookings' do
  @all_bookings = GymBooking.show_all_bookings()
  erb(:all_bookings)
end

get '/addmember' do
  erb(:add_member)
end

get '/addgymclass' do
  erb(:add_gymclass)
end

post '/addmember' do
  @member = GymMember.new(params)
  @member.add_to_db()
  erb(:member_added)
end

post '/addgymclass' do
  @gym_class = GymClass.new(params)
  @gym_class.add_to_db()
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
