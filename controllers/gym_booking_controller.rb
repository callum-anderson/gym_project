require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../model/GymMember.rb')
require_relative('../model/GymClass.rb')
require_relative('../model/GymInstructor.rb')
require_relative('../db/sql_runner.rb')
also_reload('../model/*')

get '/gym_booking' do
  erb :'gym_booking/index', :layout => :gym_booking_layout
end

delete '/gym_booking/:id/delete' do
  @booking = GymBooking.object_from_db(params['id']).delete()
  @booking_details = {'first_name' => params['first_name'],
                      'last_name' => params['last_name'],
                      'name' => params['name']}
  erb :'gym_booking/gym_booking_deleted', :layout => :gym_booking_layout
end

put '/gym_booking/member' do
  new_booking = GymBooking.new({'gym_class'=> params['gym_class'],
                                      'gym_member'=>params['id']})
  if new_booking.booking_exists?
    erb :'gym_booking/already_booked_to_class', :layout => :gym_member_layout
  elsif GymClass.class_full?(params['gym_class'])
    erb :'gym_booking/gym_class_full', :layout => :gym_member_layout
  else
    new_booking.save()
    @booking_details = new_booking.show_booking_details()
    erb :'gym_booking/gym_member_added_to_class', :layout => :gym_member_layout
  end
end

put '/gym_booking/class' do
  new_booking = GymBooking.new({'gym_class' => params['id'],
                                    'gym_member' => params['member']})
  if new_booking.booking_exists?
    erb :'gym_booking/already_booked_to_class', :layout => :gym_class_layout
  elsif GymClass.class_full?(params['id'])
    erb :'gym_booking/gym_class_full', :layout => :gym_class_layout
  else
    new_booking.save()
    @booking_details = new_booking.show_booking_details()
    erb :'gym_booking/gym_member_added_to_class', :layout => :gym_class_layout
  end
end

put '/gym_booking/class_assign' do
  new_booking = GymBooking.new({'gym_class' => params['gym_class'],
                                    'gym_instructor' => params['id']})
  if new_booking.assignment_exists?
    erb :'gym_booking/already_assigned_to_class', :layout => :gym_instructor_layout
  else
    new_booking.save()
    @booking_details = new_booking.show_assignment_details()
    erb :'gym_booking/gym_instructor_assigned_to_class', :layout => :gym_instructor_layout
  end
end
