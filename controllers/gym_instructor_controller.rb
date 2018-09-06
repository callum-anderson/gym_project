require('sinatra')
require('sinatra/contrib/all')  if development?
require_relative('../model/GymMember.rb')
require_relative('../model/GymClass.rb')
require_relative('../model/GymBooking.rb')
require_relative('../db/sql_runner.rb')
# also_reload('../model/*')

get '/gym_instructor' do
  erb :'gym_instructor/index', :layout => :gym_instructor_layout
end

get '/gym_instructor/new' do
  erb :'gym_instructor/new'
end

post '/gym_instructor' do
  @instructor = GymInstructor.new(params)
  @instructor.save()
  erb :'gym_instructor/gym_instructor_added', :layout => :gym_instructor_layout
end

put '/gym_instructor/:id' do
  @instructor = GymInstructor.new(params)
  @instructor.update()
  erb :'gym_instructor/gym_instructor_updated', :layout => :gym_instructor_layout
end

delete '/gym_instructor/:id/delete' do
  @instructor = GymInstructor.new(params)
  @instructor.delete()
  erb :'gym_instructor/gym_instructor_deleted', :layout => :gym_instructor_layout
end
