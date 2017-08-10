ActiveAdmin.register_page I18n.t('active_admin.leaderboard.name') do
  menu label: proc { I18n.t('active_admin.leaderboard.name') },
       priority: 2

  content title: proc { I18n.t('active_admin.leaderboard.name') } do #title: I18n.t('active_admin.leaderboard.name')
    images = Kaminari.paginate_array(Image.ordered_by_rating).page(params[:page]).per(10)
    render 'admin/rating', images: images
  end
end