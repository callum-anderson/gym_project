require_relative('sql_runner.rb')
require_relative('../model/GymMember.rb')
require_relative('../model/GymClass.rb')
require_relative('../model/GymBooking.rb')

johndoe = GymMember.new({'first_name' => 'John', 'last_name' => 'Doe',
                'age' => 28, 'contact_number' => '07742346788', 'email' => 'john-doe@gmail.com' })
johndoe.add_to_db()

carolbrown = GymMember.new({'first_name' => 'Carol', 'last_name' => 'Brown',
                'age' => 47, 'contact_number' => '07742844375', 'email' => 'cbrown@tiscali.com' })
carolbrown.add_to_db()

joebloggs = GymMember.new({'first_name' => 'Joe', 'last_name' => 'Bloggs',
                'age' => 22, 'contact_number' => '07742824721', 'email' => 'joe_bloggs@sky.com' })
joebloggs.add_to_db()

aerobics = GymClass.new({'name' => 'Aerobics', 'capacity' => 28})
aerobics.add_to_db()
spinclass = GymClass.new({'name' => 'Spin Class', 'capacity' => 18})
spinclass.add_to_db()
circuits = GymClass.new({'name' => 'Circuits'})
circuits.add_to_db()
