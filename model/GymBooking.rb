class GymBooking
  attr_reader(:id, :gym_class, :member)
  def initialize(booking_details)
    @gym_class_id = booking_details['gym_class']
    @gym_member_id = booking_details['gym_member']
    @gym_instructor_id = booking_details['gym_instructor']
    @id = booking_details['id'].to_i() if booking_details['id']
  end

  def save()
    sql_string = "INSERT INTO gym_bookings (gym_class_id, gym_member_id, gym_instructor_id)
                  VALUES ($1, $2, $3) RETURNING id"
    values = [@gym_class_id, @gym_member_id, @gym_instructor_id]
    sql_return = SqlRun.sql_run(sql_string, values)
    @id = sql_return[0]['id']
  end

  def delete()
    sql_string = "DELETE FROM gym_bookings
                  WHERE id = $1"
    values = [@id]
    SqlRun.sql_run(sql_string, values)
  end

  def show_booking_details()
    sql_string = "SELECT m.first_name, m.last_name, c.name, b.id
                  FROM gym_members AS m INNER JOIN gym_bookings AS b
                  ON m.id = b.gym_member_id
                  INNER JOIN gym_classes AS c
                  ON b.gym_class_id = c.id
                  WHERE b.id = $1"
    sql_return = SqlRun.sql_run(sql_string, [@id])
    return sql_return
  end

  def show_assignment_details()
    sql_string = "SELECT i.first_name, i.last_name, c.name, b.id
                  FROM gym_instructors AS i INNER JOIN gym_bookings AS b
                  ON i.id = b.gym_instructor_id
                  INNER JOIN gym_classes AS c
                  ON b.gym_class_id = c.id
                  WHERE b.id = $1"
    sql_return = SqlRun.sql_run(sql_string, [@id])
    return sql_return
  end

  def booking_exists?
    sql_string = "SELECT * FROM gym_bookings
                  WHERE gym_class_id = $1 AND gym_member_id = $2"
    values = [@gym_class_id, @gym_member_id]
    sql_return = SqlRun.sql_run(sql_string, values)
    return true if sql_return.ntuples > 0
    return false
  end

  def assignment_exists?
    sql_string = "SELECT * FROM gym_bookings
                  WHERE gym_class_id = $1 AND gym_instructor_id = $2"
    values = [@gym_class_id, @gym_instructor_id]
    sql_return = SqlRun.sql_run(sql_string, values)
    return true if sql_return.ntuples > 0
    return false
  end

  def self.object_from_db(id)
    sql_string = "SELECT * FROM gym_bookings
                  WHERE id = $1"
    values = [id]
    sql_return = GymBooking.new(SqlRun.sql_run(sql_string, values)[0])
    return sql_return
  end

  def self.show_all_bookings()
    sql_string = "SELECT m.first_name, m.last_name, c.name, b.id
                  FROM gym_members AS m INNER JOIN gym_bookings AS b
                  ON m.id = b.gym_member_id
                  INNER JOIN gym_classes AS c
                  ON b.gym_class_id = c.id
                  ORDER BY c.name ASC"
    sql_return = SqlRun.sql_run(sql_string)
    return sql_return
  end

end
