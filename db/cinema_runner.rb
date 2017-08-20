require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')
require_relative('../models/screening')

require('pry-byebug')

Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Ryan Forgie', 'funds' => 20})
  customer1.save()
customer2 = Customer.new({ 'name' => 'Emily Dean', 'funds' => 15 })
  customer2.save()
customer3 = Customer.new({ 'name' => 'Louis Griffiths', 'funds' => 10 })
  customer3.save()

film1 = Film.new({ 'title' => 'Blade Runner', 'price' => 10 })
  film1.save()
film2 = Film.new({ 'title' => 'Jurassic Park', 'price' => 10 })
  film2.save()

screening1 = Screening.new({ 'screen' => 1, 'time' => '20:00'})
  screening1.save()
screening2 = Screening.new({ 'screen' => 2, 'time' => '14:00'})
  screening2.save()
screening3 = Screening.new({ 'screen' => 3, 'time' => '10:00'})
  screening3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id })
  ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id, 'screening_id' => screening2.id})
  ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
  ticket3.save()


# customer1.name = "Chris Hales"
# customer1.update
#
# film1.title = "Dunkirk"
# film1.update

  binding.pry
  nil
