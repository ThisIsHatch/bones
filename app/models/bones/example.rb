module Bones
  class Example 
    
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_accessor :id
    attr_accessor :email
    attr_accessor :password
    attr_accessor :required
    attr_accessor :optional
    attr_accessor :disabled
    attr_accessor :error
    attr_accessor :no_label
    attr_accessor :text_area
    attr_accessor :check_box
    attr_accessor :radio
    attr_accessor :radio_collection
    attr_accessor :check_box_collection
    attr_accessor :select_collection

    validates :required, :presence => true
      
    def initialize(*args)
      super
      add_error_message_to_field
    end
      
    def add_error_message_to_field
      self.errors.add :error, 'Has a validation error message'
    end
    
    def persisted?; true; end

  end
  
end if Rails.env == 'development'

# == Schema Information
#
# Table name: examples
#
#  id                   :integer         not null, primary key
#  created_at           :datetime
#  updated_at           :datetime
#  email                :string(255)
#  password             :string(255)
#  required             :string(255)
#  optional             :string(255)
#  disabled             :string(255)
#  error                :string(255)
#  no_label             :string(255)
#  text_area            :text
#  check_box            :boolean         default(TRUE)
#  radio                :boolean         default(TRUE)
#  radio_collection     :string(255)
#  check_box_collection :string(255)
#  select_collection    :string(255)
#

