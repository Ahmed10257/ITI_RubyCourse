module Logger
  def self.log_info(message)
  current_time=Time.now
  log="#{current_time} -- info -- #{message}\n"
  File.write("app.logs", log, mode: "a")
  end
  def self.log_error(message)
    current_time=Time.now
    log="#{current_time} -- error -- #{message}\n"
    File.write("app.logs", log, mode: "a")
  end
  def self.log_warning(message)
    current_time=Time.now
    log="#{current_time} -- warning -- #{message}\n"
    File.write("app.logs", log, mode: "a")
  end
end
