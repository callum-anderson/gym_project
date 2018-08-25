class GymBooking
  attr_reader('id')
  def initialize(booking_details)
    @gym_class = booking_details['gym_class']
    @member = booking_details['member']
    @id = booking_details['id'].to_i() if booking_details['id']
  end

  def add_to_db()
    sql_string = "INSERT INTO gym_bookings (gym_class, member)
                  VALUES ($1, $2) RETURNING id"
    values = [@gym_class, @member]
    sql_return = SqlRun.sql_run(sql_string, values)
    @id = sql_return[0]['id']
  end

  def delete()
    sql_string = "DELETE FROM gym_bookings
                  WHERE id = $1"
    values = [@id]
    SqlRun.sql_run(sql_string, values)
  end

  def self.object_from_db(id)
    sql_string = "SELECT * FROM gym_bookings
                  WHERE id = $1"
    values = [id]
    sql_return = GymBooking.new(SqlRun.sql_run(sql_string, values)[0])
    return sql_return
  end

  def self.delete_by_id(id)
    self.object_from_db(id).delete()
  end

  def self.return_booking_id(gym_class_id, member_id)
    sql_string = "SELECT id FROM gym_bookings
                  WHERE gym_class = $1 AND member = $2"
    values = [gym_class_id, member_id]
    return SqlRun.sql_run(sql_string, values)[0]['id'].to_i()
  end

  def self.show_all_bookings()
    sql_string = "SELECT m.first_name, m.last_name, c.name
                  FROM members AS m INNER JOIN gym_bookings AS b
                  ON m.id = b.member
                  INNER JOIN gym_classes AS c
                  ON b.gym_class = c.id"
    sql_return = SqlRun.sql_run(sql_string)
    return sql_return
  end

end
