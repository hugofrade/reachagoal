class ObjectivesController < ApplicationController
  before_action :set_objective, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index]
  before_filter :is_private?
  
  # GET /objectives
  # GET /objectives.json
  def index
    @objectives = Objective.all
  end

  # GET /objectives/1
  # GET /objectives/1.json
	def show
		labelsset = @objective.objective_values.map do |obj|  
			if ((((Time.now - obj.created_at) / 1.hour).round) <= 72 ) 
				obj.created_at
			else 
				obj.created_at.to_date 
			end
		end 
	 		    
		dataset = @objective.objective_values.map{ |obj| obj.value }
	     
	# 	zip = labelsset.map{|obj| obj.to_date}.zip(dataset).group_by{|k,v| k}
	# 	hash= Hash[zip.collect {|k,v| [k, v.map{|v| v.last}.inject(0, :+)]}]
		
		hash = Hash[labelsset.uniq.map{|v| [v,0]}]
		labelsset.each_with_index{|v,i| hash[v] = hash[v] + dataset[i] }
	
		@hash = hash
	    @dataset = hash.values
	    @labelsset = hash.keys
	    
	    
		#Podio -> ordena os utilizadores#
		users= @objective.objective_values.map{|obj| obj.user_id}
		values_user = @objective.objective_values.map{|obj| obj.value}	
		hash1 = Hash[users.uniq.map{|v| [v,0]}]
		users.each_with_index{|v,i| hash1[v] = hash1[v] + values_user[i] }
		@values_per_user = Hash[hash1.sort_by{|k, v| v}.reverse]
		
		
		values_current_user = @objective.objective_values.reject{|obj| obj.value if obj.user_id!=current_user.id}.map{|obj| obj.value}
				
		labelsset_user = @objective.objective_values.reject{|c| c.user_id != current_user.id}.map do |obj|  
			if ((((Time.now - obj.created_at) / 1.hour).round) <= 72 ) 
				obj.created_at
			else 
				obj.created_at.to_date 
			end
		end 
		
		@hash2 = Hash[labelsset_user.uniq.map{|v| [v,0]}]
		labelsset_user.each_with_index{|v,i| @hash2[v] = @hash2[v] + values_current_user[i] }
	    @dataset_user = @hash2.values
	    @labelsset_user = @hash2.keys

		
		
		
		
		@user_friends=current_user.friends.paginate(:page => params[:page], :per_page => 5)
		@values = ObjectiveValue.where("objective_id=?",@objective.id).order("id DESC").paginate(:page => params[:page], :per_page => 5)	
	
	
  end
  
  def ajax_values
	@values = ObjectiveValue.where("objective_id=?",params[:id]).order("id DESC").paginate(:page => params[:page], :per_page => 5)
	@objective = Objective.find(params[:id])
	render template: "objectives/_values", layout: false
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
    @objective.start_day=DateTime.now
	@objective.privacy= "1"
    @objective.user_id = current_user.id
      if @objective.save
        @user_objective=UserObjective.new(user_id: @objective.user_id, objective_id: @objective.id)
  	    @user_objective.save
       	redirect_to @objective, notice: t('sucnewchal').capitalize
      else
        render action: 'new'
      end
    
  end

  # PATCH/PUT /objectives/1
  # PATCH/PUT /objectives/1.json
  def update
    respond_to do |format|
      if @objective.update(objective_params)
        format.html { redirect_to @objective, notice: t('suceditchal').capitalize }
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
  
  	@objective.user_objectives.destroy_all
  	@objective.objective_values.destroy_all
    @objective.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end



  def add_value
  	session[:return_to] ||= request.referer
  	@objective_value = ObjectiveValue.new()
    @objective_value.value = params[:value]
    @objective_value.description = params[:description]
    @objective_value.objective_id = params[:objective_id]
    @objective_value.user_id = current_user.id

    if @objective_value.save
    	if params[:previous_page].to_s == "objective"
     		redirect_to @objective_value.objective, notice: t('addvaluesuc').capitalize
     		session.delete(:return_to)
     	else
	 		redirect_to session.delete(:return_to), notice: t('addvaluesuc').capitalize
	 	end

    else
     	if params[:previous_page].to_s == "objective"
     		redirect_to @objective_value.objective, alert: t('erroraddvalue').capitalize
     		session.delete(:return_to)
     	else
	 		redirect_to session.delete(:return_to), alert: t('erroraddvalue').capitalize
	 	end     	
    end

  end




  def remove_value
  	@objective_value = ObjectiveValue.find(params[:id])
  	@objective=@objective_value.objective
    @objective_value.destroy
    respond_to do |format|
      format.html { redirect_to @objective }
    end
  end
  
  def add_comment
  	@new_comment = ObjectiveComment.new()
    @new_comment.comment = params[:comment]
    @new_comment.objective_id = params[:objective_id]
    @new_comment.user_id = current_user.id

    if @new_comment.save
     	redirect_to @new_comment.objective, notice: t('sucnewcomment')
    else
     	redirect_to @new_comment.objective, alert: t('errornewcomment')
    end

  end
  
  def remove_comment
  	@comment = ObjectiveComment.find(params[:id])
  	@objective=@comment.objective
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @objective }
    end
  end

  def add_friend
    @user_objective=UserObjective.new(user_id: params[:friend_id], objective_id: params[:objective_id] )
  	@user_objective.save
	redirect_to Objective.find(params[:objective_id]), notice: "Amigo adicionado com sucesso"	

  end




  private
    # Use callbacks to share common setup or constraints between actions.
  
     def is_private?
     	if (((!current_user.has_ownership?(@objective.id) if !@objective.blank?) || (!current_user.has_ownership?(params[:objective_id]) if !params[:objective_id].blank?)) && ((@objective.privacy == 0 if !@objective.blank?) || (Objective.find(params[:objective_id]).privacy == 0 if !params[:objective_id].blank? )))
		 	redirect_to :back
      	end
	 end
	 
    def set_objective
      @objective = Objective.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def objective_params
      params.require(:objective).permit(:name, :start_day, :end_day, :price, :objective_type, :privacy, :user_id, :photo, :category_id)
    end
end
