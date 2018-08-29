class GymInstructor
attr_reader('id')
attr_accessor('first_name', 'last_name')
  def initialize(instructor_details)
    @first_name = instructor_details['first_name']
    @last_name = instructor_details['last_name']
    @id = instructor_details['id'].to_i() if member_details['id']
  end

end
