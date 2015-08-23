require('spec_helper')

describe(Client) do

  before() do
    @client = Client.new({:name => "bob", :stylists_id => nil, :id => nil})
  end

  describe('#all') do
    it('will return an empty array of clients at first') do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('#name') do
    it('will return the client name') do
      expect(@client.name()).to(eq("bob"))
    end
  end

  describe('#id') do
    it('returns the id of the client') do
      expect(@client.id()).to(eq(nil))
    end
  end

  describe('#stylists_id') do
    it('returns the id of the client') do
      expect(@client.stylists_id()).to(eq(nil))
    end
  end


  describe('#==') do
    it('returns true if stylist is same as other stylist') do
      test_client = Client.new({:name => "bob", :id => nil, :specialty_id => nil})
      expect(test_client).to(eq(test_client))
    end
  end

  describe('#save') do
    it("records record of the stylist") do
      @client.save()
      expect(Client.all).to(eq([@client]))
    end
  end

  describe('.find') do
    it('finds a client by the ID number') do
      @client.save()
      test_client = Client.new({:name => "sam", :id => nil})
      test_client.save()
      expect(Client.find(test_client.id())).to(eq(test_client))
    end
  end

  describe('#delete') do
    it('deletes client from database') do
      @client.save()
      test_client = Client.new({:name => "sam", :id => nil})
      test_client.save()
      test_client.delete()
      @client.delete()
      expect(Client.all()).to(eq([]))
    end
  end

  describe('#update') do
    it('updates the clients name') do
      @client.save()
      @client.update({:name => "sam"})
      expect(@client.name()).to(eq("sam"))
    end
  end


end
