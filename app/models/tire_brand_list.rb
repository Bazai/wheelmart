class TireBrandList
  def self.all
    ["Barum",
    "BFGoodrich",
    "Bridgestone",
    "CARBON",
    "Continental",
    "Dunlop",
    "Dunlop JP",
    "Gislaved",
    "Goodyear",
    "Hankook",
    "Kumho",
    "Michelin",
    "Nexen",
    "Nokian",
    "Nordman",
    "Pirelli",
    "Toyo",
    "Yokohama"]
  end

  def self.all_lol_edition
    [
    ["Барум", "Barum"],
    ["Бриджстоун","Bridgestone"],
    ["БФ гудрич","BF Goodrich"],
    ["Континенталь","Continental"],
    ["Гиславед","Gislaved"],
    ["ГУД-ЕАР","Goodyear"],
    ["Данлоп","Dunlop"],
    ["Данлоп G","Dunlop G"],
    ["Кумхо","Kumho"],
    ["Ханкук","Hankook"],
    ["Мишелин","Michelin"],
    ["Нексен","Nexen"],
    ["Нокиан","Nokian"],
    ["Нордман","Nordman"],
    ["Пирелли","Pirelli"],
    ["Тойя","Toyo"],
    ["Йокохама","Yokohama"]
    ]
  end

  def self.from_db
    Tyre.find_by_sql('select distinct brand_name from tyres').map(&:brand_name)
  end
end