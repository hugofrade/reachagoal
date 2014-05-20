module Autentication

	def check_user
		if(session[:user_id].blank?)
			flash[:error]="Erro de autenticação"
			redirect_to root_path;
		end
	end

end