class ScrapperWorker
  def logger
    Delayed::Worker.logger
  end

  def self.logger
    Delayed::Worker.logger
  end

  def self.interact_with_scrapper(action=Scrapper::RUN)
    begin
      puts "Begin to interact with scrapper #{action}"

      # get running scrapping task id
      tasks = ProcessingTask.where(status: "in-progress")

      puts "Number of tasks #{tasks.count}"

      no_of_tasks = tasks.count

      if no_of_tasks > 1
        # return error
        logger.error "There something went wrong with start/stop/pause scrapper"

      elsif no_of_tasks == 1
        
        puts "Received action request from admin to #{action}"

        # interact with running scrapper
        task = tasks.first

        if task.action_code != Scrapper::STOP
          task.action_code = action
          task.save!
        end
      else
        puts "Initiate new scrapper process #{action} - #{Scrapper::RUN}"

        # initiate a new scrapper instance
        task = ProcessingTask.create
        task.action_code = action
        task.start_at = Time.now
        task.progress = 0
        task.status = "in-progress"
        task.save

        Scrapper.new(Delayed::Worker.logger, task.id).delay.scrape_products
      end
    rescue Exception => e
      logger.error "Message: #{e.message}"
      logger.error "Backtrace: #{e.backtrace.join("\n")}"
    end
  end
end
