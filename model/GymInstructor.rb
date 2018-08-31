class GymInstructor
attr_reader('id')
attr_accessor('first_name', 'last_name')
  def initialize(instructor_details)
    @first_name = instructor_details['first_name']
    @last_name = instructor_details['last_name']
    @id = instructor_details['id'].to_i() if instructor_details['id']
  end

  def save()
    sql_string = "INSERT INTO gym_instructors (first_name, last_name)
                  VALUES ($1,$2) RETURNING id"
    values = [@first_name, @last_name]
    sql_return = SqlRun.sql_run(sql_string, values)
    @id = sql_return[0]['id']
  end

  def delete()
    sql_string = "DELETE FROM gym_instructors
                  WHERE id = $1"
    SqlRun.sql_run(sql_string, [@id])
  end

  # def show_info()
  #   sql_string = "SELECT * FROM gym_instructors
  #                 WHERE id = $1"
  #   sql_return = SqlRun.sql_run(sql_string, [@id])
  #   return sql_return[0]
  # end

  def update()
    sql_string = "UPDATE gym_instructors
                  SET (first_name, last_name)
                  = ($1,$2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRun.sql_run(sql_string, values)
  end

  def show_assignments()
    sql_string = "SELECT c.name FROM gym_instructors AS i
                  INNER JOIN gym_bookings AS b
                  ON i.id = b.gym_instructor_id
                  INNER JOIN gym_classes AS c
                  ON b.gym_class_id = c.id
                  WHERE i.id = $1"
    SqlRun.sql_run(sql_string, [@id])
  end

  def self.view_all()
    sql_string = "SELECT * FROM gym_instructors
                  ORDER BY last_name"
    sql_return = SqlRun.sql_run(sql_string).map{|i|GymInstructor.new(i)}
  end

end
