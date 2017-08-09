class DelayedDeleteWorker
  include Sidekiq::Worker

  def perform(image_id)
    image = Image.find_by(id: image_id)
    if image &.declined?
      LB.remove_member(image_id)
      image.destroy
    end
  end
end
