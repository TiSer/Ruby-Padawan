class Categorization < ActiveRecord::Base
  self.table_name = "categories_posts"
  belongs_to :category
  belongs_to :post
end
