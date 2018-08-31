require_relative('sql_runner.rb')
require_relative('../model/GymMember.rb')
require_relative('../model/GymClass.rb')
require_relative('../model/GymBooking.rb')
require_relative('../model/GymInstructor.rb')

johndoe = GymMember.new({'first_name' => 'John', 'last_name' => 'Doe',
                'age' => 28, 'contact_number' => '07742346788', 'email' => 'john-doe@gmail.com' })
johndoe.save()

carolbrown = GymMember.new({'first_name' => 'Carol', 'last_name' => 'Brown',
                'age' => 47, 'contact_number' => '07742844375', 'email' => 'cbrown@tiscali.co.uk' })
carolbrown.save()

joebloggs = GymMember.new({'first_name' => 'Joe', 'last_name' => 'Bloggs',
                'age' => 22, 'contact_number' => '07742824721', 'email' => 'joe_bloggs@sky.com' })
joebloggs.save()
mickyflynn = GymMember.new({'first_name' => 'Micky', 'last_name' => 'Flynn',
                'age' => 42, 'contact_number' => '07742824388', 'email' => 'mflynn@sky.com' })
mickyflynn.save()
janedawson = GymMember.new({'first_name' => 'Jane', 'last_name' => 'Dawson',
                'age' => 33, 'contact_number' => '07742824547', 'email' => 'janedawson@talktalk.co.uk' })
janedawson.save()
dianesmith = GymMember.new({'first_name' => 'Diane', 'last_name' => 'Smith',
                'age' => 25, 'contact_number' => '07742824729', 'email' => 'd_smith@hotmail.com' })
dianesmith.save()

aerobics = GymClass.new({'name' => 'Aerobics', 'capacity' => 28})
aerobics.save()
spinclass = GymClass.new({'name' => 'Spin Class', 'capacity' => 18})
spinclass.save()
circuits = GymClass.new({'name' => 'Circuits'})
circuits.save()
yoga = GymClass.new({'name' => 'Yoga', 'capacity' => 28})
yoga.save()
weights = GymClass.new({'name' => 'Weights', 'capacity' => 18})
weights.save()

mrmotivator = GymInstructor.new({'first_name' => 'Mr', 'last_name' => 'Motivator'})
mrmotivator.save()
jfondant = GymInstructor.new({'first_name' => 'Jane', 'last_name' => 'Fondant'})
jfondant.save()
sgerrard = GymInstructor.new({'first_name' => 'Stevie', 'last_name' => 'Gerrard'})
sgerrard.save()
dmccall = GymInstructor.new({'first_name' => 'Dayveena', 'last_name' => 'McCall'})
dmccall.save()
jmichaels = GymInstructor.new({'first_name' => 'Jylian', 'last_name' => 'Michaels'})
jmichaels.save()
