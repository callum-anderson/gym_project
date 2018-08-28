require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../model/GymMember.rb')
require_relative('../model/GymClass.rb')
require_relative('../model/GymBooking.rb')
require_relative('../db/sql_runner.rb')
also_reload('../model/*')

get '/gym_booking' do
  @all_bookings = GymBooking.show_all_bookings()
  erb :'gym_booking/index', :layout => :gym_booking_layout
end

delete '/gym_booking/:id/delete' do
  @booking = GymBooking.object_from_db(params['id']).delete()
  @booking_details = {'first_name' => params['first_name'],
                      'last_name' => params['last_name'],
                      'name' => params['name']}
  @all_bookings = GymBooking.show_all_bookings()
  erb :'gym_booking/gym_booking_deleted', :layout => :gym_booking_layout
end

post '/update_member/:id' do
  @member = GymMember.new(params)
  @member.update()
  @all_members = GymMember.view_all()
  erb(:member_updated)
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
