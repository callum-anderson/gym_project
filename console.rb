require_relative('db/sql_runner.rb')
require_relative('model/GymMember.rb')
require_relative('model/GymClass.rb')
require_relative('model/GymBooking.rb')


# johndoe = GymMember.new({'first_name' => 'John', 'last_name' => 'Doe',
#                 'age' => 28 })
# johndoe.add_to_db()
#
# p johndoe.show_info()

# aerobics = GymClass.new({'name' => 'Aerobics'})
#
# aerobics.add_to_db()
#
# p aerobics.show_info()
#
# aerobics.name = "Spin Class"
# aerobics.capacity = 30
#
# aerobics.update()
#
# p GymClass.show_info_by_id(5)

# gymclass = GymBooking.new({'gym_class' => 5, 'member' => 4})
# gymclass.add_to_db()
# p gymclass.id

GymClass.remove_member_by_id(7,6)
