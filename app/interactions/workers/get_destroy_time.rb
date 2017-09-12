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
      return unless created_time
      Sidekiq::DELAYED_DESTROY_TIME - (Time.now - created_time)
    end
  end
end
