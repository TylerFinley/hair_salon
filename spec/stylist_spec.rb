require('spec_helper')

describe(Stylist) do

 before() do
   @stylist = Stylist.new({:name => "jim", :id => nil})
 end

 describe('#all') do
   it('will return an empty array of stylists at first') do
     expect(Stylist.all()).to(eq([]))
   end
 end

 describe('#name') do
   it('will return the stylists name') do
     expect(@stylist.name()).to(eq("jim"))
   end
 end

 describe('#id') do
   it('will return the stylists id') do
     expect(@stylist.id()).to be_an_instance_of(Fixnum)
   end
 end

 describe('#==') do
   it('returns true if stylist is same as other stylist') do
     test_stylist = Stylist.new({:name => "jim", :id => nil})
     expect(@stylist).to(eq(test_stylist))
   end
 end

 describe('#save') do
   it("records a record of the stylist") do
     @stylist.save()
     expect(Stylist.all).to(eq([@stylist]))
   end
 end

 describe('.find') do
   it('will find a stylist by the ID number') do
     @stylist.save()
     test_stylist = Stylist.new({:name => "greg", :id => nil})
     test_stylist.save()
     expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
   end
 end

 describe('#delete') do
   it(' will delete a stylist from database') do
     test_stylist = Stylist.new({:name => "greg", :id => nil})
     test_stylist.save()
     test_stylist.delete()
     expect(Stylist.all()).to(eq([]))
   end
 end

 describe('#clients') do
   it('returns array of clients for the stylist') do
     @stylist.save()
     test_client = Client.new({:name => "meow", :id => nil, :stylists_id => @stylist.id()})
     test_client.save()
     test_client2 = Client.new({:name => "doug", :id => nil, :stylists_id => @stylist.id()})
     test_client2.save()
     expect(@stylist.clients()).to(eq([test_client, test_client2]))
   end
 end

 describe('#update') do
   it('updates the stylists name') do
     @stylist.save()
     @stylist.update({:name => "jim"})
     expect(@stylist.name()).to(eq("jim"))
   end
 end
 end
