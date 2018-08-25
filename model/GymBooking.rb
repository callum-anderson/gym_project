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
  
end
