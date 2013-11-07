class Bones::BonesController < ApplicationController

  def elements
    if  defined?(Kaminari)
      pages = 50.times.map { |n| Bones::Example.new(:required => 'Yep', :email => "email-#{n}@example.com") }
      @pages = Kaminari.paginate_array(pages).page(params[:page]).per(5)
    end
  end

end
