require('pg')

class SqlRun

  def self.sql_run(sql_string, values=nil)
    # sql_conn = PG.connect({dbname: 'gym_project', host: 'localhost'})
    sql_conn = PG.connect({dbname: 'd1u03n6vshffqi',
                          host: 'ec2-107-22-169-45.compute-1.amazonaws.com',
                          port: 5432, user: 'trwymsajxdwjbu',
                          password: 'ce34cc62802f1c7ebb9d9bbb33768cc0ae291febf559a11254003fafc4fc7be7'})
    sql_conn.prepare("run", sql_string)
    sql_return = sql_conn.exec_prepared("run", values)
    sql_conn.close()
    return sql_return
  end

end
