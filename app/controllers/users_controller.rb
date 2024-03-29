class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :destroy]
	skip_before_action :verify_authenticity_token, :only => [:login, :register, :update, :loginWithGoogle]
	skip_before_action :authorized, only: [:login, :register, :loginWithGoogle]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
	def show
		uid = current_user().id
		@user_info = User.find(uid).user_info

		render :json => { user_info: @user_info }
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
	end
	
	def login
		@user = User.find_by(username: params[:username])
		if @user.password == params[:password]
			@token = encode_token(user_id: @user.id)

			render json: {token: @token}
		end
	end

	def register
		@user = User.create({
			username: params[:username],
			password: params[:password],
			email: params[:email],
		})

		@user.create_user_info({
			first_name: params[:first_name],
			last_name: params[:last_name],
		})

		@token = encode_token(user_id: @user.id)

		render json: {token: @token}
	end

	def loginWithGoogle
		@token = ""
	
		if (User.find_by(email: params[:email]) === nil)
			@user = User.create({
				email: params[:email],
			})

			@user.create_user_info({
				first_name: params[:first_name],
				last_name: params[:last_name],
			})

			@token = encode_token(user_id: @user.id, token_id: params[:tokenID])
		else
			@user = User.find_by(email: params[:email]);
			@token = encode_token(user_id: @user.id, token_id: params[:tokenID])
		end

		render json: {token: @token}
	end

  # POST /users
  # POST /users.json
  def create
		@user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
	def update
		uid = current_user().id
		@user_info = User.find(uid).user_info
		@user_info.update({
			first_name: params[:first_name],
			last_name: params[:last_name],
		})
		render :json => {status: :successfully}

    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to @user, notice: 'User was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :tokenID)
    end
end
