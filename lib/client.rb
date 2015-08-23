class Client
  attr_reader(:name, :stylists_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
    @stylist_id = attributes[:stylists_id].to_i()
  end

  define_singleton_method (:all) do
    all_clients = []
    clients = DB.exec("SELECT * FROM clients;")
    clients.each() do |client|
      name = client.fetch('name')
      id = client.fetch('id').to_i()
      stylist_id = client.fetch('stylists_id').to_i()
      all_clients.push(Client.new({:name => name, :id => id, :stylists_id => stylists_id}))
    end
    all_clients
  end

  define_method (:==) do |other_client|
    self.name().==(other_client.name())
    .&(self.id().==(other_client.id()))
    .&(self.stylists_id().==(other_client.stylists_id()))
  end

  define_method (:save) do
    new_client = DB.exec("INSERT INTO clients (name, stylists_id) VALUES ('#{@name}', #{@stylists_id}) RETURNING id;")
    @id = new_client.first().fetch("id").to_i()
  end

  define_singleton_method (:find) do |id|
    found_client= nil
    results = DB.exec("SELECT * FROM clients WHERE id = #{id};")
    results.each() do |result|
      name = result.fetch("name")
      stylist_id = result.fetch("stylist_id").to_i()
      found_client = Client.new({:name => name, :id => id, :stylist_id => stylist_id})
    end
    found_client
  end

  define_method (:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end

  define_method (:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
  end

end
