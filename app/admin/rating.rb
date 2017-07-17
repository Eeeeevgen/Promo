ActiveAdmin.register_page "Ratings" do
  content do
    render 'admin/rating', rating: LeaderboardI::Top.run!
  end
end