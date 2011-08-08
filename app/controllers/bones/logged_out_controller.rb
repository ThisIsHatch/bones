class Bones::LoggedOutController < LoggedOutController

  def elements
    @pages = Bones::Example.wibble.page(params[:page] || 1)
  end
  
end
