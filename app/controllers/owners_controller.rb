class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_owner,  only: [:show, :edit, :update, :destroy]
  before_action :correct_owner,    only: [:show, :edit, :update, :destroy]



  # GET /owners
  # GET /owners.json
  def index
    @owners = Owner.all
  end

  # GET /owners/1
  # GET /owners/1.json
  def show
  end

  # GET /owners/new
  def new
    @owner = Owner.new
    @owner.build_address(params[:address])
  end

  # GET /owners/1/edit
  def edit
    @owner.address ||= @owner.build_address(params[:address])
  end

  # POST /owners
  # POST /owners.json
  def create
    @owner = Owner.new(owner_params)

    respond_to do |format|
      if @owner.save
        sign_in @owner
        format.html { redirect_to root_path, notice: 'Owner was successfully created.' }
        format.json { render action: 'show', status: :created, location: @owner }
      else
        format.html { render action: 'new' }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owners/1
  # PATCH/PUT /owners/1.json
  def update
    respond_to do |format|
      if @owner.update(owner_params)
        format.html { redirect_to @owner, notice: 'Owner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owners/1
  # DELETE /owners/1.json
  def destroy
    @owner.destroy
    respond_to do |format|
      format.html { redirect_to owners_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_params
      params.require(:owner).permit(:first_name, :last_name, :email, :password, :password_confirmation, :address_attributes => [:id, :line1, :line2, :city, :state, :zip])
    end

    def signed_in_owner
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."  
      end   
    end

    def correct_owner
      redirect_to(root_path) unless current_owner?(@owner)      
    end
end
