require('PG')

class SqlRun

  def self.sql_run(sql_string, values=nil)
    sql_conn = PG.connect({dbname: 'gym_project', host: 'localhost'})
    sql_conn.prepare("run", sql_string)
    sql_return = sql_conn.exec_prepared("run", values)
    sql_conn.close()
    return sql_return
  end

end
