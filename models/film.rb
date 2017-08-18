require_relative("../db/sql_runner")

class Film

  attr_reader(:id)
  attr_accessor(:title, :price)

  def initialize( details )
    @id = details['id'].to_i
    @title = details['title']
    @price = details['price'].to_i
  end

  def save()
    sql = '
      INSERT INTO films (title, price)
      VALUES ($1, $2)
      returning id;'
      values = [@title, @price]
      film = SqlRunner.run( sql, values).first
      @id = film['id'].to_i
  end

  def update()
    sql = '
      UPDATE films SET (title, price)
      = ($1, $2)
      WHERE id = $3;'
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    return Film.map_items(films)
  end

  def self.delete_all()
    sql = 'DELETE FROM films'
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM films WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers_booked()
    sql = '
      SELECT customers.* FROM customers
      INNER JOIN tickets ON customers.id = tickets.customer_id
      WHERE film_id = $1'
    values = [@id]
    results = SqlRunner.run(sql, values)
    return Customer.map_items(results)
  end

  def self.map_items(rows)
    return rows.map {|row| Film.new(row)}
  end

end
