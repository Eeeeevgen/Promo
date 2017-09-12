module Workers
  class DestroyWorker < ActiveInteraction::Base
    integer :image_id

    def execute
      ss = Sidekiq::ScheduledSet.new
      ss.each do |s|
        if s.args[0].to_i == image_id
          s.delete
          break
        end
      end
    end
  end
end
