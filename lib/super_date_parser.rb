require "super_date_parser/version"

module SuperDateParser
  
  def string_to_date_strings(string)
    DateService.new(string).string_to_date_strings
  end

  def string_to_dates(string)
    DateService.new(string).string_to_dates
  end
end
