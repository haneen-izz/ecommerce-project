class ApplicationController < ActionController::Base
     before_action :configure_permitted_parameters, if: :devise_controller?
     #######################################################################
     if @rand_c != nil
     else
     before_action :rand_cart
     end

     protected
   
     def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:email ,:password, :role])
     end

     #######################################################################
     #After user sign in this method will check if the user [admin , role , owner] and based of the entered email will be redirected to the target page
    def after_sign_in_path_for(resource)
        case resource.role
        when 'admin'
             admin_home_path
        when 'customer'
             session[:old_rand_cart] = session[:rand_cart] 
             session[:rand_cart] = current_user.id
             session[:user_id] = current_user.id
             root_path 
        when 'owner'
             session[:user_id] = current_user.id
             owner_home_path
        end
     end

        
     #######################################################################
     #This method for authorization will check if the current user is admin it will give him the persmissions i used it in the controllers to prevent any other roles from make any operation or see the page
     
     def admin_only
     redirect_to new_user_session_path unless current_user && current_user.admin?
     end


     #######################################################################
     def rand_cart 
          if session[:rand_cart]
             @rand_c =  session[:rand_cart] 
          else 
             @rand_c = rand(1..1000)  
             session[:rand_cart] = @rand_c 
          end
     end
end
