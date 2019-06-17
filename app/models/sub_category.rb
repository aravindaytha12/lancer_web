# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  title          :string
#  services_count :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class SubCategory < ApplicationRecord
  has_many :attributes
  has_many :services
  belongs_to :category, counter_cache: true

  CAT_LIST = ["Graphic & Design", "Digital Marketing", "Writing & Translation", "Video & Animation", "Music & Audio", "Programming & Tech", "Business", "Lifestyle"]
end