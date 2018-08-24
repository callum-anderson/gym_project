class GymClass
  attr_accessor('name', 'capacity')
  attr_reader('id')

  def initialize(class_details)
    @name = class_details['name']
    @capacity = (class_details['capacity'] || 20).to_i()
    @id = class_details['id'] if class_details['id']
  end

  def add_to_db()
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

end
