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

put '/gym_booking/member' do
  new_booking = GymBooking.new({'gym_class'=> params['gym_class'],
                                      'member'=>params['id']})
  new_booking.save()
  @booking_details = new_booking.show_booking_details()
  @all_members = GymMember.view_all()
  @all_classes = GymClass.view_all()
  erb :'gym_booking/gym_member_added_to_class', :layout => :gym_member_layout
end

put '/gym_booking/class' do
  new_booking = GymBooking.new({'gym_class'=> params['id'],
                                    'member'=>params['member']})
  new_booking.save()
  @booking_details = new_booking.show_booking_details()
  @all_members = GymMember.view_all()
  @all_classes = GymClass.view_all()
  erb :'gym_booking/gym_member_added_to_class', :layout => :gym_class_layout
end
