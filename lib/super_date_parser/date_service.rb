class DateService

  # Params:
  # - date_string (String): String to be converted
  def initialize(date_string)
    @date_string = date_string
    Rails.logger.debug("Parsing date #{date_string}")

    # May 18
    @date_type_1 = /^[aA-zZ]+ [0-9]+$/
    # Sat, May 18
    @date_type_2 = /^[aA-zZ]+, [aA-zZ]+ [0-9]+$/
    # Sat, May 18, 6 – 10 PM CDT
    @date_type_3 = /^[aA-zZ]+, [aA-zZ]+ [0-9]+, [0-9]+ – [0-9]+ (AM|PM) [aA-zZ]+$/
    # Wed, May 15 – Thu, May 16"
    @date_type_4 = /^[aA-zZ]+, [aA-zZ]+ [0-9]+ – [aA-zZ]+, [aA-zZ]+ [0-9]+$/
    # Fri, May 17, 9 PM – Sat, May 18, 1 AM CDT
    @date_type_5 = /^[aA-zZ]+, [aA-zZ]+ [0-9]+, [0-9]+ (AM|PM) – [aA-zZ]+, [aA-zZ]+ [0-9]+, [0-9]+ (AM|PM) [aA-zZ]+$/
    # Sat, May 18, 9 PM – Sun, May 19, 12 AM
    @date_type_6 = /^[aA-zZ]+, [aA-zZ]+ [0-9]+, [0-9]+ (AM|PM) – [aA-zZ]+, [aA-zZ]+ [0-9]+, [0-9]+ (AM|PM)+$/
    # Sat, May 18, 9 PM CDT
    @date_type_7 = /^[aA-zZ]+, [aA-zZ]+ [0-9]+, [0-9]+ (AM|PM) [aA-zZ]+$/
    # Sat, May 18, 9 PM
    @date_type_8 = /^[aA-zZ]+, [aA-zZ]+ [0-9]+, [0-9]+ (AM|PM)$/

    @date_type_arrays = [@date_type_1, @date_type_2, @date_type_3, @date_type_4, @date_type_5, @date_type_6, @date_type_7, @date_type_8]
  end

  # Returns datetimes from string
  def string_to_dates
    start_string, end_string = string_to_date_strings
    return DateTime.parse(start_string), DateTime.parse(end_string)
  end

  # Returns strings that can be used to create dates
  def string_to_date_strings
    string_array = @date_string.split(',')
    case date_type(@date_string)
    when @date_type_1.to_s
      parse_date_type_1(string_array)
    when @date_type_2.to_s
      parse_date_type_2(string_array)
    when @date_type_3.to_s
      parse_date_type_3(string_array)
    when @date_type_4.to_s
      parse_date_type_4(string_array)
    when @date_type_5.to_s, @date_type_6.to_s
      parse_date_type_5(string_array)
    when @date_type_7.to_s, @date_type_8.to_s
      parse_date_type_7(string_array)
    else
      Rails.logger.debug "No matching date regex for: #{@date_string}"
      return nil, nil
    end
  end

  def date_type(date_string)
    @date_type_arrays.find{|classification_type| date_string.match?(classification_type) }.to_s
  end

  # May 18
  def parse_date_type_1(date_string_array)
    return date_string_array[0], date_string_array[0]
  end

  # Sat, May 18
  def parse_date_type_2(date_string_array)
    day = date_string_array[0]
    month_date = date_string_array[1]
    month = month_date.split(' ')[0]
    date = month_date.split(' ')[1]
    return [day, month, date].join(' '), [day, month, date].join(' ')
  end

  # "Sat, May 18, 6 – 10 PM CDT"
  def parse_date_type_3(date_string_array)
    day = date_string_array[0]
    month_date = date_string_array[1]
    month = month_date.split(' ')[0]
    date = month_date.split(' ')[1]

    start_time = date_string_array[2].split('–')[0].strip
    end_time = date_string_array[2].split('–')[1].split(' ')[0].strip
    pm_am = date_string_array[2].split('– ')[1].split(' ')[1].strip
    return [day, month, date, start_time, pm_am].join(' '), [day, month, date, end_time, pm_am].join(' ')
  end

  # Wed, May 15 – Thu, May 16"
  def parse_date_type_4(date_string_array)
    day = date_string_array[0]
    month_date = date_string_array[1]
    month = month_date.split(' ')[0]
    date = month_date.split(' ')[1]

    end_day = date_string_array[1].split('–')[1].strip
    end_month = date_string_array[2].split(' ')[0]
    end_date = date_string_array[2].split(' ')[1]
    return [day, month, date].join(' '), [end_day, end_month, end_date].join(' ')
  end

  # Fri, May 17, 9 PM – Sat, May 18, 1 AM CDT
  def parse_date_type_5(date_string_array)
    day = date_string_array[0]
    start_month = date_string_array[1].split(' ')[0]
    start_date = date_string_array[1].split(' ')[1]

    start_time = date_string_array[2].split('–')[0].split(' ')[0]
    start_am_pm = date_string_array[2].split('–')[0].split(' ')[1]

    end_day = date_string_array[2].split('–')[1].strip

    end_month = date_string_array[3].split(' ')[0]
    end_date = date_string_array[3].split(' ')[1]

    end_time = date_string_array[4].split(' ')[0]
    end_am_pm = date_string_array[4].split(' ')[1]

    return [day, start_month, start_date, start_time, start_am_pm].join(' '), [end_day, end_month, end_date, end_time, end_am_pm].join(' ')
  end

  # Sat, May 18, 9 PM CDT
  def parse_date_type_7(date_string_array)
    day = date_string_array[0]
    month_date = date_string_array[1]
    month = month_date.split(' ')[0]
    date = month_date.split(' ')[1]

    start_time = date_string_array[2].split(' ')[0].strip
    pm_am = date_string_array[2].split(' ')[1].strip
    return [day, month, date, start_time, pm_am].join(' '), nil
  end
end