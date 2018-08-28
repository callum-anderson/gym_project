require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('model/GymMember.rb')
require_relative('model/GymClass.rb')
require_relative('model/GymBooking.rb')
also_reload('model/*')

get '/gym_member' do
  @all_members = GymMember.view_all()
  @all_classes = GymClass.view_all()
  erb :'gym_member/index', :layout => :gym_member_layout
end

get '/gym_member/new' do
  erb :'gym_member/new'
end

post '/gym_member' do
  @member = GymMember.new(params)
  @member.save()
  erb :'gym_member/gym_member_added', :layout => :gym_member_layout
end

post '/gym_member/:id/delete' do
  @member = GymMember.new(params)
  @all_classes = GymClass.view_all()
  @member.delete()
  @all_members = GymMember.view_all()
  erb :'gym_member/gym_member_deleted', :layout => :gym_member_layout
end
