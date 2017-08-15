require("pg")

class SpaceCowboy

    attr_accessor( :name, :species, :bounty_value, :danger_level, :last_known_location, :homeworld, :favourite_weapon, :cashed_in, :collected_by )

  def initialize( cowboy_details )
    @id = cowboy_details["id"].to_i() if cowboy_details["id"]
    @name = cowboy_details["name"]
    @species = cowboy_details["species"]
    @bounty_value = cowboy_details["bounty_value"]
    @danger_level = cowboy_details["danger_level"]
    @last_known_location = cowboy_details["last_known_location"]
    @homeworld = cowboy_details["homeworld"]
    @favourite_weapon = cowboy_details["favourite_weapon"]
    @cashed_in = cowboy_details["cashed_in"]
    @collected_by = cowboy_details["collected_by"]
  end

  def save()
    db = PG.connect({ dbname: "bounty_hunters", host: "localhost"})
    sql = "
      INSERT INTO bounty_hunters
      (name, species, bounty_value, danger_level, last_known_location, homeworld, favourite_weapon, cashed_in, collected_by)
      VALUES
      ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      RETURNING *;
    "
    values = [@name, @species, @bounty_value, @danger_level, @last_known_location, @homeworld, @favourite_weapon, @cashed_in, @collected_by]
    db.prepare("save", sql)
    pg_result = db.exec_prepared("save", values)
    saved_space_cowboy_hash = pg_result[0]

    id_string = saved_space_cowboy_hash["id"]
    @id = id_string.to_i()

    db.close()
  end

  def SpaceCowboy.all()
    db = PG.connect({ dbname: "bounty_hunters", host: "localhost"})
    sql = "SELECT * FROM bounty_hunters;"
    values = []
    db.prepare("all", sql)
    spacecowboys = db.exec_prepared("all", values)
    db.close()
    return spacecowboys
  end

  def SpaceCowboy.delete_all()
    db = PG.connect({ dbname: "bounty_hunters", host: "localhost" })
    sql = "DELETE FROM bounty_hunters;"
    values = []
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all", values)
    db.close()
  end

  def delete()
    db = PG.connect({ dbname: "bounty_hunters", host: "localhost" })
    sql = "
      DELETE FROM bounty_hunters
      WHERE id = $1;
    "
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close
  end

  def update()
    db = PG.connect({dbname: "bounty_hunters", host: "localhost"})
    sql = "
    UPDATE bounty_hunters
    SET
    (name, species, bounty_value, danger_level, last_known_location, homeworld, favourite_weapon, cashed_in, collected_by)
    =
    ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    WHERE
    id = $10;
    "
    values = [@name, @species, @bounty_value, @danger_level, @last_known_location, @homeworld, @favourite_weapon, @cashed_in, @collected_by]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

end

# cowboy_1 = SpaceCowboy.new({
#       "name" => "Bojangles",
#       "species" => "Jangolian",
#       "favourite_weapon" => "Spear of Destiny",
#       "homeworld" => "Jangolia"
#   })
#
#   cowboy_2 = SpaceCowboy.new({
#         "name" => "Boba Fett",
#         "species" => "Spaceman",
#         "favourite_weapon" => "Lasergun",
#         "homeworld" => "Fettland",
#         "bounty_value" => "5000"
#     })
#
# puts cowboy_2.inspect
