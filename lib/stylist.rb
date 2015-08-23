class Stylist
  attr_reader(:name, :id)

  define_method (:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method (:all) do
    stylists = []
    all_stylists = DB.exec("SELECT * FROM stylists;")
    all_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:name => name, :id => id}))
    end
    stylists
  end

  define_method (:==) do |another_stylist|
    self.name().==(another_stylist.name())
  end

  define_method (:save) do
    new_stylist = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = new_stylist.first.fetch("id").to_i()
  end

  define_singleton_method (:find) do |results|
    found_stylist= nil
    results = DB.exec("SELECT * FROM stylists WHERE id = #{id};")
    results.each() do |result|
      name = result.fetch("name")
      found_stylist = Stylist.new({:name => name, :id => id})
    end
    found_stylist
  end

  define_method (:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
    DB.exec("DELETE FROM clients WHERE stylists_id = #{self.id()}")
  end

  define_method (:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method (:clients) do
    stylist_clients = []
    clients = DB.exec("SELECT * FROM clients WHERE stylists_id = #{self.id()};")
    clients.each() do |client|
      name = client.fetch('name')
      id = client.fetch('id').to_i()
      stylists_id = client.fetch('stylists_id').to_i()
      stylist_clients.push(Client.new({:name => name, :stylists_id => stylists_id, :id => id}))
    end
    stylist_clients
  end
end
