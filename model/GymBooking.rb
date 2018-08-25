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

  def self.delete_by_id(id)
    sql_string = "DELETE FROM gym_bookings WHERE id = $1"
    values = [id]
    SqlRun.sql_run(sql_string, values)
  end

  def self.find_booking_id(gym_class_id, member_id)
    sql_string = "SELECT id FROM gym_bookings
                  WHERE gym_class = $1 AND member = $2"
    values = [gym_class_id, member_id]
    return SqlRun.sql_run(sql_string, values)[0]['id'].to_i()
  end

end
