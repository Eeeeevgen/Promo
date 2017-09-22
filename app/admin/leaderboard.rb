ActiveAdmin.register_page I18n.t('active_admin.leaderboard.name') do
  menu label: proc { I18n.t('active_admin.leaderboard.name') },
       priority: 2

  content title: proc { I18n.t('active_admin.leaderboard.name') } do
    images = Kaminari.paginate_array(Image.ordered_by_rating).page(params[:page]).per(20)
    render 'admin/rating', images: images
  end

  action_item do
    link_to I18n.t('active_admin.leaderboard.rebuild_button'), admin_leaderboard_rebuild_path
  end

  page_action :rebuild, method: :get do
    LB.delete_leaderboard
    LB = Leaderboard.new('likes',
                         Leaderboard::DEFAULT_OPTIONS,
                         redis_connection: REDIS)

    Image.accepted.each do |image|
      LB.rank_member(image.id, image.likes_count)
    end

    redirect_to admin_leaderboard_path, notice: I18n.t('active_admin.leaderboard.rebuild_message')
  end
end
