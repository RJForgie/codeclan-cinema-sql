require_relative("../db/sql_runner")

class Ticket

  attr_reader(:id)
  attr_accessor(:customer_id, :film_id, :screening_id)

  def initialize ( details )
    @id = details['id'].to_i
    @customer_id = details['customer_id'].to_i
    @film_id = details['film_id'].to_i
    @screening_id = details['screening_id'].to_i
  end

  def save()
    sql = '
      INSERT INTO tickets (customer_id, film_id, screening_id)
      VALUES ($1, $2, $3)
      RETURNING id'
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run( sql, values ).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = Ticket.map_items(tickets)
    return result
  end

  def self.delete_all()
    sql = 'DELETE FROM tickets'
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM tickets WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(rows)
    return rows.map {|row| Ticket.new(row)}
  end



end
