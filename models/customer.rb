require_relative("../db/sql_runner")

class Customer

  attr_reader(:id)
  attr_accessor(:name, :funds)

  def initialize( details )
    @id = details['id'].to_i
    @name = details['name']
    @funds = details['funds'].to_i
  end

  def save()
    sql = '
      INSERT INTO customers (name, funds)
      VALUES ($1, $2)
      returning id;'
      values = [@name, @funds]
      customer = SqlRunner.run( sql, values).first
      @id = customer['id'].to_i
  end

  def update()
    sql = '
      UPDATE customers SET (name, funds)
      = ($1, $2)
      WHERE id = $3;'
      values = [@name, @funds, @id]
      SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM customers'
    values = []
    customers = SqlRunner.run(sql, values)
    result = Customer.map_items(customers)
    return result
  end

  def self.delete_all()
    sql = 'DELETE FROM customers'
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM customers WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films_watched()
    sql = '
      SELECT films.* FROM films
      INNER JOIN tickets ON films.id = tickets.film_id
      WHERE customer_id = $1'
    values = [@id]
    results = SqlRunner.run(sql, values)
    return Film.map_items(results)
  end

  def self.map_items(rows)
    return rows.map {|row| Customer.new(row)}
  end

end
