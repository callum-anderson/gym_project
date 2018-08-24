require_relative('db/sql_runner.rb')
require_relative('model/GymMember.rb')

def test
  sql_string = "SELECT * FROM gym_classes"
  puts "test"
  puts SqlRun.sql_run(sql_string)
end

p GymMember.view_all.values

# johndoe = GymMember.new({'first_name' => 'John', 'last_name' => 'Doe',
#                 'age' => 28, 'contact_number' => '07742387421', 'email' => 'johndoe@gmail.com'})
# johndoe.add_to_db()
