module Bones
  class Example < ActiveRecord::Base

    establish_connection(:adapter => "sqlite3", :database => ":memory:")
  
    after_initialize :add_error_message_to_field

    ActiveRecord::Migration.class_eval do

      def self.connection
        Example.connection
      end

      create_table :examples, :force => true do |t|
        t.timestamps
        t.string    :email
        t.string    :password
        t.string    :required
        t.string    :optional
        t.string    :disabled
        t.string    :error
        t.string    :no_label
        t.text      :text_area
        t.boolean   :check_box, :default => true
        t.boolean   :radio, :default => true
        t.string    :radio_collection
        t.string    :check_box_collection
        t.string    :select_collection
      end
    
    end

  
    paginates_per 5
  
    validates_presence_of :required
    
    def add_error_message_to_field
      self.errors.add :error, 'Has a validation error message'
    end

  end
  
  
  module ExamplePagination

    def wibble
      where(:required => 'Yep').order(:email)
    end
    
  end
  
  Example.extend(Bones::ExamplePagination)
  
  50.times { |n| Bones::Example.create(:required => 'Yep', :email => "email-#{n}@example.com") }
  
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

