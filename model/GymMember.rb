class GymMember
attr_reader('id')
attr_accessor('first_name', 'last_name', 'age', 'contact_number', 'email')
  def initialize(member_details)
    @first_name = member_details['first_name']
    @last_name = member_details['last_name']
    @age = member_details['age'].to_i()
    @contact_number = member_details['contact_number'] || ""
    @email = member_details['email'] || ""
    @id = member_details['id'].to_i() if member_details['id']
  end

  def save()
    sql_string = "INSERT INTO gym_members (first_name, last_name, age, contact_number, email)
                  VALUES ($1,$2,$3,$4,$5) RETURNING id"
    values = [@first_name, @last_name, @age, @contact_number, @email]
    sql_return = SqlRun.sql_run(sql_string, values)
    @id = sql_return[0]['id']
  end

  def delete()
    sql_string = "DELETE FROM gym_members
                  WHERE id = $1"
    values = [@id]
    SqlRun.sql_run(sql_string, values)
  end

  def show_bookings()
    sql_string = "SELECT * FROM gym_members AS m
                  INNER JOIN gym_bookings AS b
                  ON m.id = b.gym_member_id
                  INNER JOIN gym_classes AS c
                  ON b.gym_class_id = c.id
                  WHERE m.id = $1"
    values = [@id]
    SqlRun.sql_run(sql_string, values)
  end

  def update()
    sql_string = "UPDATE gym_members
                  SET (first_name, last_name, age, contact_number, email)
                  = ($1,$2,$3,$4,$5) WHERE id = $6"
    values = [@first_name, @last_name, @age, @contact_number, @email, @id]
    SqlRun.sql_run(sql_string, values)
  end

  def self.view_all()
    sql_string = "SELECT * FROM gym_members
                  ORDER BY last_name"
    sql_return = SqlRun.sql_run(sql_string).map{|m|GymMember.new(m)}
  end

end
