class Question < ActiveRecord::Base
  require "constants"
  attr_accessible :title, :description
  
  validates :title, :presence => true
  validates :description, :presence => true  

  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_many :categorizations, :dependent => :destroy
  has_many :categories, :through => :categorizations

  default_scope order('created_at DESC')
  scope :simple_questions, where(["questions.type = 'SimpleQuestion'"])
  scope :challenge_questions, where(["questions.type = 'ChallengeQuestion'"])

  include Constants::CategoryConstant

  def validate    
    self.errors.add(:categories, " Please categorize the question with a valid category ") if self.categories.empty?
  end

  def categorize(category)
    remove_deselected_category(category) unless category[:title].blank?
    category[:title].split.each_with_index do |_category, index|
      if _category =~ /(\w+)/ && index < Constants::CategoryConstant::MAX_NUMBER_OF_QUESTION_CATEGORIES
          unless existing_category = Category.find_by_title(_category)            
            self.categories.build(:title => _category.to_s)
          else
            add_category(existing_category) unless self.categories.include?(existing_category)
          end
       end
     end
  end

  def get_categories
    categories_list = ""
    categories.each{|category| categories_list += "#{category.title} " }
    categories_list
  end


  def add_category(existing_category)    
    self.categories << existing_category
  end

  def remove_deselected_category(category)
    to_be_removed = deselected_categories(category)
    to_be_removed.each{|_category|  self.categories.delete(_category) }    
  end

private
 def deselected_categories(category)
   self.categories - Category.find_all_by_title(category[:title].split)
 end
  
end
  

