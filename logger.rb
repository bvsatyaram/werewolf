class Logger
  def log(str, force = false)
    return if !force && @master_hide_output
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

  def master_disable_logging
    @master_hide_output = true
  end

  def master_enable_logging
    @master_hide_output = false
  end
end