class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
	skip_before_action :verify_authenticity_token, :only => :create
	
	# GET /boards
  # GET /boards.json
	def index
		uid = current_user().id
		@boards = User.find(uid).boards

		render :json => @boards
  end

  # GET /boards/1
  # GET /boards/1.json
	def show
		render :json => @board
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
	def create
		uid = current_user().id
		@board = User.find(uid).boards.create({
			name: params[:name]
		})

		render :json => @board
		
		# if @board.save
		# 	render :json => @board, status: :created
		# else
		# 	render json: @board.errors, status: :unprocessable_entity
		# end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
	end
	
	def privateBoard
		uid = current_user().id
		@boards = User.find(uid).boards.where(public: false);

		render :json => @boards
	end

	def publicBoard
		uid = current_user().id
		@boards = User.find(uid).boards.where(public: true);

		render :json => @boards
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.permit(:name, :public, :user_id)
    end
end
