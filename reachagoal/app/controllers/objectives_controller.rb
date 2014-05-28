class ObjectivesController < ApplicationController
  before_action :set_objective, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  # GET /objectives
  # GET /objectives.json
  def index
    @objectives = Objective.all
  end

  # GET /objectives/1
  # GET /objectives/1.json
  def show
  end

  # GET /objectives/new
  def new
    @objective = Objective.new
  end

  # GET /objectives/1/edit
  def edit
  end

  # POST /objectives
  # POST /objectives.json
  def create
 
    @objective = Objective.new(objective_params)
    @objective.user_id = current_user.id
    
      if @objective.save
        @user_objective=UserObjective.new(user_id: @objective.user_id, objective_id: @objective.id)
  	    @user_objective.save
       	redirect_to @objective, notice: 'Objective was successfully created.'
      else
        render action: 'new'
      end
    
  end

  # PATCH/PUT /objectives/1
  # PATCH/PUT /objectives/1.json
  def update
    respond_to do |format|
      if @objective.update(objective_params)
        format.html { redirect_to @objective, notice: 'Objective was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /objectives/1
  # DELETE /objectives/1.json
  def destroy
    @objective.destroy
    respond_to do |format|
      format.html { redirect_to objectives_url }
      format.json { head :no_content }
    end
  end


  def add_value
  	@objective_value = ObjectiveValue.new()
    @objective_value.value = params[:value]
    @objective_value.description = params[:description]
    @objective_value.objective_id = params[:objective_id]
    @objective_value.user_id = current_user.id

    if @objective_value.save
     	redirect_to @objective_value.objective, notice: 'Objective Value was successfully created.'
    else
     	redirect_to @objective_value.objective, error: 'Error creating new Objective Value'
    end

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_objective
      @objective = Objective.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def objective_params
      params.require(:objective).permit(:name, :description, :start_day, :end_day, :price, :objective_type, :privacy, :user_id, :photo)
    end
end
