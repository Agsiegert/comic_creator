class Comic < ActiveRecord::Base
  has_many :panels, :dependent => :destroy
  accepts_nested_attributes_for :panels
end
