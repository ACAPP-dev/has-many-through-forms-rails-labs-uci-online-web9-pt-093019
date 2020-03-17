class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  #accepts_nested_attributes_for :categories, reject_if: proc {|attributes| attributes[:name].empty?}

  def categories_attributes=(category_hash)
    if !category_hash["0"][:name].empty?
      category = Category.find_or_create_by(category_hash["0"])
      self.post_categories.build(category: category)
    end
  end
end
