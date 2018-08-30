require_relative('sql_runner.rb')
require_relative('../model/GymMember.rb')
require_relative('../model/GymClass.rb')
require_relative('../model/GymBooking.rb')
require_relative('../model/GymInstructor.rb')

johndoe = GymMember.new({'first_name' => 'John', 'last_name' => 'Doe',
                'age' => 28, 'contact_number' => '07742346788', 'email' => 'john-doe@gmail.com' })
johndoe.save()

carolbrown = GymMember.new({'first_name' => 'Carol', 'last_name' => 'Brown',
                'age' => 47, 'contact_number' => '07742844375', 'email' => 'cbrown@tiscali.com' })
carolbrown.save()

joebloggs = GymMember.new({'first_name' => 'Joe', 'last_name' => 'Bloggs',
                'age' => 22, 'contact_number' => '07742824721', 'email' => 'joe_bloggs@sky.com' })
joebloggs.save()

aerobics = GymClass.new({'name' => 'Aerobics', 'capacity' => 28})
aerobics.save()
spinclass = GymClass.new({'name' => 'Spin Class', 'capacity' => 18})
spinclass.save()
circuits = GymClass.new({'name' => 'Circuits'})
circuits.save()

dthomson = GymInstructor.new({'first_name' => 'David', 'last_name' => 'Thomson'})
dthomson.save()
jfonda = GymInstructor.new({'first_name' => 'Jane', 'last_name' => 'Fonda'})
jfonda.save()
sgerrard = GymInstructor.new({'first_name' => 'Stevie', 'last_name' => 'Gerrard'})
sgerrard.save()
