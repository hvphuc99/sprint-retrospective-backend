class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
	skip_before_action :verify_authenticity_token, :only => [:create, :destroy, :update]
	
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
		uid = current_user().id
		if uid === @board.user_id
			render :json => @board
		else
			if @board.public === true
				@board.collaborators.create(user_id: uid)
				render :json => @board
			else
				render :json => @board.errors, status: :unprocessable_entity
			end
		end
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

		@board.columns.create([
			{
				name: "Well Went"
			},
			{
				name: "To Improve"
			},
			{
				name: "Action Items"
			},
		])

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
		uid = current_user().id
		if uid === @board.user_id
			@board.update(board_params)
			render :json => { status: :successfully}
		end

    # respond_to do |format|
    #   if @board.update(board_params)
    #     format.html { redirect_to @board, notice: 'Board was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @board }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @board.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
	def destroy
		@board.destroy
		render :json => { status: :successfully}
	end
	
	def privateBoard
		@uid = current_user().id
		@boards = User.find(@uid).boards.where(public: false)

		render :json => @boards
	end

	def publicBoard
		uid = current_user().id
		boardArray = Array.new
		@boards = User.find(uid).boards.where(public: true)
		boardCollaborator = User.find(uid).collaborators
		@boards.each do |b|
			boardArray << Board.find(b.id)
		end
		boardCollaborator.each do |bc| 
			bid = bc.board_id
			boardArray << Board.find(bid)
		end

		boardArray = boardArray.uniq

		render :json => boardArray
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
