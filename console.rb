require("pry-byebug")
require_relative("./models/space_cowboy")

SpaceCowboy.delete_all()

cowboy_1 = SpaceCowboy.new({
      "name" => "Bojangles",
      "species" => "Jangolian",
      "favourite_weapon" => "Spear of Destiny",
      "homeworld" => "Jangolia"
  })

    cowboy_2 = SpaceCowboy.new({
          "name" => "Boba Fett",
          "species" => "Spaceman",
          "favourite_weapon" => "Lasergun",
          "homeworld" => "Fettland",
          "bounty_value" => "5000"
  })

  cowboy_1.save
  cowboy_2.save

  spacecowboys = SpaceCowboy.all()

  spacecowboys_readable = spacecowboys.map { |spacecowboy| SpaceCowboy.new(spacecowboy)}

  binding.pry
  nil
