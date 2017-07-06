ActiveAdmin.register_page "Ratings" do
  content do
    rating = LbTop.run!
    table class: "ratings" do
      thead do
        tr do
          th do
            'Member'
          end
          th do
            'Score'
          end
          th do
            'Rank'
          end
        end
      end
      tbody do
        rating.each do |row|
          tr do
            td do
              row[:member]
            end
            td do
              row[:score]
            end
            td do
              row[:rank]
            end
          end
        end
      end

    end
    # rating.each do |row|
    #   span row
    # end
  end
end