class StoresController < ApplicationController
    before_action :set_store, only: [:show, :destroy,:edit,:update]
	before_action :admin_only  ,:only => [:show,:index, :destroy,:edit,:update ] 
	before_action :set_user_id , :only => [:edit,:new ] 

    # customer store
	def new 
		@store = Store.new    
	end
	def create 	
		@store = Store.new(store_params)
		unless current_user.admin?
		   @store.user = current_user
	       @store.save 
		else
           @store.save
	    end
		   user_role
    end
	def index
		@stores = Store.all
	end 
	def show 
	end
    def update
        @store.update(store_params)
		user_role
    end
	def edit
    end
    def destroy
        @store.destroy
		user_role
    end


	# owner store
	def owner_store 
		@stores = Store.where(user_id: current_user.id)
		@user_id = current_user.id
	end 
	def owner_new_store 
		@store = Store.new    
	end
	def edit_owner_store
	    
	end

	private 
	def store_params
		params.require(:store).permit(:name , :user_id )
	end
    def set_store
        @store = Store.find(params[:id])
	end
	def set_user_id
		@users = User.all
	end
	def user_role
		case current_user.role
		when "admin"
		 	 redirect_to stores_path
		else
			 redirect_to owner_store_path   
	    end
	end
end
