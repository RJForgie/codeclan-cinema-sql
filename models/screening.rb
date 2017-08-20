require_relative("../db/sql_runner")

class Screening

  attr_reader(:id)
  attr_accessor(:name, :time)

  def initialize( details )
    @id = details['id'].to_i
    @film_id = details['film_id'].to_i
    @time = details['time']
  end

  def save()
    sql = '
      INSERT INTO screenings (film_id, time)
      VALUES ($1, $2)
      returning id;'
      values = [@film_id, @time]
      screening = SqlRunner.run( sql, values).first
      @id = screening['id'].to_i
  end

  def update()
    sql = '
      UPDATE screenings SET (film_id, time)
      = ($1, $2)
      WHERE id = $3;'
      values = [@film_id, @time, @id]
      SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM screenings'
    values = []
    screenings = SqlRunner.run(sql, values)
    result = Screening.map_items(screenings)
    return result
  end

  def self.delete_all()
    sql = 'DELETE FROM screenings'
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM screenings WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(rows)
    return rows.map {|row| Screening.new(row)}
  end

end
