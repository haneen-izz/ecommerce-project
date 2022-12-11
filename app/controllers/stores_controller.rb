class StoresController < ApplicationController
    before_action :set_store, only: [:show, :destroy,:edit,:update,:destroy_owner_store, :edit_owner_store ,:update_owner_store]
	before_action :admin_only  ,:only => [:show,:index, :destroy,:edit,:update ] 

    # customer store
	def new 
		@store = Store.new    
		@users = User.all
	end
	def create 
		@store = Store.new(store_params)
		@store.save 
        redirect_to stores_path
	
	end
	def index
		@stores = Store.all
	end 
	def show 
	end
    def update
        @store.update(store_params)
        redirect_to stores_path
    end
	def edit
        
    end
    def destroy
        @store.destroy
		redirect_to stores_path
    end


	# owner store
	def owner_store 
		@stores = Store.where(user_id: current_user.id)
		@user_id = current_user.id
	end 
	def owner_new_store 
		@store = Store.new    
	end
    def create_owner_store
		
		@store = Store.new(store_params)
		@store.user = current_user
	    @store.save 
        redirect_to owner_store_path   
	end
	def edit_owner_store
	    
	end
	def update_owner_store
	    @store.update(store_params)
        redirect_to owner_store_path
	end
	def destroy_owner_store
        @store.destroy
		redirect_to owner_store_path
    end

	private 
	def store_params
		params.require(:store).permit(:name , :user_id )
	end
    def set_store
        @store = Store.find(params[:id])
	end
end
