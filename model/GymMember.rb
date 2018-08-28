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
    sql_string = "INSERT INTO members (first_name, last_name, age, contact_number, email)
                  VALUES ($1,$2,$3,$4,$5) RETURNING id"
    values = [@first_name, @last_name, @age, @contact_number, @email]
    sql_return = SqlRun.sql_run(sql_string, values)
    @id = sql_return[0]['id']
  end

  def delete()
    sql_string = "DELETE FROM members
                  WHERE id = $1"
    values = [@id]
    SqlRun.sql_run(sql_string, values)
  end

  def show_info()
    sql_string = "SELECT * FROM members
                  WHERE id = $1"
    values = [@id]
    sql_return = SqlRun.sql_run(sql_string, values)
    return sql_return[0]
  end

  def update()
    sql_string = "UPDATE members
                  SET (first_name, last_name, age, contact_number, email)
                  = ($1,$2,$3,$4,$5) WHERE id = $6"
    values = [@first_name, @last_name, @age, @contact_number, @email, @id]
    SqlRun.sql_run(sql_string, values)
  end

  def self.object_from_db(id)
    sql_string = "SELECT * FROM members
                  WHERE id = $1"
    values = [id]
    sql_return = GymMember.new(SqlRun.sql_run(sql_string, values)[0])
    return sql_return
  end

  def self.delete_by_id(id)
    self.object_from_db(id).delete()
  end

  def self.view_all()
    sql_string = "SELECT * FROM members
                  ORDER BY last_name"
    sql_return = SqlRun.sql_run(sql_string).map{|m|GymMember.new(m)}
  end

  def self.show_info_by_id(id)
    self.object_from_db(id).show_info()
  end

end
