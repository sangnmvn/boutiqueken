class ProcessingTask < ActiveRecord::Base
  def check_existing_scrapper_process
    begin
      module_name = "scrapper"

      ProcessingTask.where(module_name: module_name, status: "in-progress").first
      
    rescue Exception => e
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace.join("\n"))
    end
  end
end
