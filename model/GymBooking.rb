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


end
