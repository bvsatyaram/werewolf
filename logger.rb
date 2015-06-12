class Logger
  def log(str)
    return if @hide_output
    puts ">> " + str
    # gets
  end

  def disable_logging
    @hide_output = true
  end

  def enable_logging
    @hide_output = false
  end
end