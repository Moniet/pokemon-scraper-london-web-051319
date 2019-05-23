require "pry"
class Pokemon
  def initialize(id: nil, name: , type:, hp:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  attr_accessor :id, :type, :name, :hp, :db

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
      SQL

    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?;"
    arr = db.execute(sql, id).flatten
    #binding.pry
    Pokemon.new(id: arr[0], name: arr[1], type: arr[2], hp: arr[3], db: db)
  end

  def alter_hp(hp, db)
    sql = "UPDATE pokemon SET hp = ? WHERE id = ?"
    db.execute(sql, hp, self.id)
    #binding.pry
  end
end
