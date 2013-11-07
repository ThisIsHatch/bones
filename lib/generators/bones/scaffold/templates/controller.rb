class <%= controller_class_name %>Controller < LoggedInController
  
  load_and_authorize_resource
  
  # GET /<%= plural_name %>
  # GET /<%= plural_name -%>.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @<%= table_name -%> }
    end
  end

  # GET /<%= plural_name -%>/1
  # GET /<%= plural_name -%>/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @<%= file_name -%> }
    end
  end

  # GET /<%= plural_name -%>/new
  # GET /<%= plural_name -%>/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @<%= file_name -%> }
    end
  end

  # GET /<%= plural_name -%>/1/edit
  def edit
  end

  # POST /<%= plural_name %>
  # POST /<%= plural_name -%>.json
  def create
    respond_to do |format|
      if @<%= orm_instance.save %>
        format.html { redirect_to @<%= file_name -%>, notice: '<%= human_name -%> was successfully created.' }
        format.json { render json: @<%= file_name -%>, status: :created, location: @<%= file_name -%> }
      else
        format.html { render action: "new" }
        format.json { render json: @<%= orm_instance.errors -%>, status: :unprocessable_entity }
      end
    end
  end

  # PUT /<%= plural_name -%>/1
  # PUT /<%= plural_name -%>/1.json
  def update
    respond_to do |format|
      if @<%= orm_instance.update_attributes("params[:#{file_name}]") %>
        format.html { redirect_to @<%= file_name -%>, notice: '<%= human_name -%> was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @<%= orm_instance.errors -%>, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= plural_name -%>/1
  # DELETE /<%= plural_name -%>/1.json
  def destroy
    flash[:notice] = @<%= orm_instance.destroy -%> ? '<%= human_name -%> was successfully deleted.' : 'Failed to delete <%= singular_name -%>.'

    respond_to do |format|
      format.html { redirect_to <%= table_name -%>_url }
      format.json { head :no_content }
    end
  end
  
end
