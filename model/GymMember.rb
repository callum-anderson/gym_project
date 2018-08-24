class GymMember
attr_reader('id')
attr_accessor('first_name', 'last_name', 'age', 'email', 'contact_number')
  def initialize(member_details)
    @first_name = member_details['first_name']
    @last_name = member_details['last_name']
    @age = member_details['age'].to_i()
    @email = member_details['email']
    @contact_number = member_details['contact_number']
    @id = member_details['id'].to_i() if member_details['id']
  end

  def add_to_db()
    sql_string = "INSERT INTO members (first_name, last_name, age, contact_number, email)
                  VALUES ($1,$2,$3,$4,$5) RETURNING id"
    values = [@first_name, @last_name, @age, @email, @contact_number]
    sql_return = SqlRun.sql_run(sql_string, values)
    @id = sql_return[0]['id']
  end

  def delete()
    sql_string = "DELETE FROM members
                  WHERE id = $1"
    values = [@id]
    SqlRun.sql_run(sql_string, values)
  end

  def self.delete_by_id(id)
    sql_string = "DELETE FROM members
                  WHERE id = $1"
    values = [id]
    SqlRun.sql_run(sql_string, values)
  end

  def self.view_all()
    sql_string = "SELECT * FROM members"
    sql_return = SqlRun.sql_run(sql_string)
    return sql_return
  end
end
