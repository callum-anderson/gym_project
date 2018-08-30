class GymClass
  attr_accessor('name', 'capacity')
  attr_reader('id')

  def initialize(class_details)
    @name = class_details['name']
    @capacity = (class_details['capacity'] || 20).to_i()
    @id = class_details['id'] if class_details['id']
  end

  def save()
    sql_string = "INSERT INTO gym_classes (name, capacity)
                  VALUES ($1, $2) RETURNING id"
    values = [@name, @capacity]
    sql_return = SqlRun.sql_run(sql_string, values)
    @id = sql_return[0]['id']
  end

  def show_info()
    sql_string = "SELECT * FROM gym_classes
                  WHERE id = $1"
    values = [@id]
    sql_return = SqlRun.sql_run(sql_string, values)
    return sql_return[0]
  end

  def update()
    sql_string = "UPDATE gym_classes
                  SET (name, capacity)
                  = ($1,$2) WHERE id = $3"
    values = [@name, @capacity, @id]
    SqlRun.sql_run(sql_string, values)
  end

  def delete()
    sql_string = "DELETE FROM gym_classes
                  WHERE id = $1"
    values = [@id]
    SqlRun.sql_run(sql_string, values)
  end

  def show_assigned_members()
    sql_string = "SELECT m.first_name, m.last_name FROM gym_members AS m
                  INNER JOIN gym_bookings AS b
                  ON m.id = b.gym_member_id
                  INNER JOIN gym_classes AS c
                  ON b.gym_class_id = c.id
                  WHERE c.id = $1"
    SqlRun.sql_run(sql_string, [@id])
  end

  def self.object_from_db(id)
    sql_string = "SELECT * FROM gym_classes
                  WHERE id = $1"
    values = [id]
    sql_return = GymClass.new(SqlRun.sql_run(sql_string, values)[0])
    return sql_return
  end

  def self.view_all()
    sql_string = "SELECT * FROM gym_classes
                  ORDER BY name"
    sql_return = SqlRun.sql_run(sql_string).map{|c|GymClass.new(c)}
    return sql_return
  end

  def self.delete_by_id(id)
    self.object_from_db(id).delete()
  end

  def self.show_info_by_id(id)
    self.object_from_db(id).show_info()
  end

  def self.add_member_by_id(gym_class_id, gym_member_id)
    GymBooking.new({'gym_class' => gym_class_id, 'gym_member' => gym_member_id}).save()
  end

  def self.remove_member_by_id(gym_class_id, gym_member_id)
    GymBooking.find_booking_id(gym_class_id, gym_member_id)
    GymBooking.delete_by_id(booking_id)
  end

  def self.class_full?(gym_class_id)
    sql_string = "SELECT * FROM gym_classes AS c
                INNER JOIN gym_bookings AS b
                ON c.id = b.gym_class_id
                WHERE c.id = $1"
    sql_return = SqlRun.sql_run(sql_string, [gym_class_id])
    return false if sql_return.ntuples == 0
    return true if sql_return.ntuples >= sql_return.first['capacity'].to_i()
    return false
  end

end
