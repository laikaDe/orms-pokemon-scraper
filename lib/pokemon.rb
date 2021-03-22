class Pokemon

    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name 
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL
  
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)

        # sql = "SELECT * FROM songs WHERE name = ?"
        # result = DB[:conn].execute(sql, name)[0]
        # Song.new(result[0], result[1], result[2])
        sql = "SELECT * FROM pokemon WHERE id = ?"
        result = db.execute(sql, id).flatten
        Pokemon.new(id: result[0], name: result[1], type: result[2], db: db)
    end
end
