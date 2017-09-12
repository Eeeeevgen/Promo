module Workers
  class GetDestroyTime < ActiveInteraction::Base
    integer :image_id

    def execute
      ss = Sidekiq::ScheduledSet.new
      created_time = nil
      ss.each do |s|
        if s.args[0].to_i == image_id
          created_time = s.created_at
          break
        end
      end
      if created_time
        time_diff = Sidekiq::DELAYED_DESTROY_TIME - (Time.now - created_time)
        human_time(time_diff)
      end
    end

    def human_time(seconds_diff)
      sign = seconds_diff.negative? ? '-' : ''

      seconds_diff = seconds_diff.to_i.abs
      hours = (seconds_diff / 3600)
      seconds_diff -= hours * 3600

      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60

      seconds = seconds_diff

      "#{sign} #{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
    end
  end
end
