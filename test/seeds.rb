ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :name
  end
end

class User < ActiveRecord::Base; end

User.create([
  {id: 1, name: 'Coda'}, {id: 3, name: 'Peter'}, {id: 5, name: 'Jeff'},
  {id: 7, name: 'James'}, {id: 9, name: 'Derek'}, {id: 11, name: 'Khaiv'},
  {id: 13, name: 'Kakas'}, {id: 15, name: 'Chester'}, {id: 17, name: 'Nicole'},
  {id: 19, name: 'Enoch'},
])
