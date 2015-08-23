require('sinatra')
require('sinatra/reloader')
require('./lib/stylist')
require('./lib/client')
also_reload('lib/**/*.rb')
require('pg')
require('pry')

DB = PG.connect({:dbname => "hair_salon_test"})

get('/') do
  erb(:index)
end

#########################
############Stylists
#########################

get('/stylists') do
  @all_stylists = Stylist.all()
  erb(:stylists)
end

post('/stylists') do
  name = params.fetch("stylist_name")
  stylist = Stylist.new({:name => name, :id => nil})
  stylist.save()
  @all_stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i())
  @stylist_clients = @stylist.clients()
  erb(:stylist)
end

get('/stylists/:id/edit') do
  @stylist = Stylist.find(params.fetch('id').to_i())
  erb(:stylist_edit)
end

patch('/stylists/:id') do
  name = params.fetch("stylists_name")
  @stylist = Stylist.find(params.fetch('id').to_i())
  @stylist.update({:name => name})
  @stylist_clients = @stylist.clients()
  erb(:stylist)
end

delete('/stylists') do
  @stylist = Stylist.find(params.fetch('stylists_id').to_i())
  @stylist.delete()
  @all_stylists = Stylist.all()
  erb(:stylists)
end

post('/clients') do
  name = params.fetch('client_name')
  @client = Client.new({:name => name})
  @client.save()
  erb(:clients)
end

#########################
############Clients
#########################

get('/clients') do
  @all_clients = Client.all()
  erb(:clients)
end


get('/clients/:id') do
  @client = Client.find(params.fetch("id").to_i())
  erb(:client)
end

delete('/clients') do
  @client = Client.find(params.fetch('client_id').to_i())
  @client.delete()
  @all_clients = Client.all()
  erb(:clients)
end

get('/clients/:id/edit') do
  @client = Client.find(params.fetch('id').to_i())
  erb(:client_edit)
end

patch('/clients/:id') do
  name = params.fetch("client_name")
  @client = Client.find(params.fetch('id').to_i())
  @client.update({:name => name})
  @all_clients = Client.all()
  erb(:clients)
end
delete('/clients') do
  Client.find(params.fetch('client_name').to_i()).delete()

  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:clients)
end
