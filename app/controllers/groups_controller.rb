class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  LIMITED_GROUPS_NUM =10
  # GET /groups
  # GET /groups.json
  def index
      @groups = Group.all      

    if params[:page]
      @page= params[:page].to_i
    else 
      @page = 1
    end

=begin    
    @groups=[]
    (1...100).each do |index|
      group ={

        id: index,
        price: 10,
      }
      @groups << group
    end
=end


#    @groups = group.all
      @first_page =(@groups.count==0)? 0:1
    @last_page=(@groups.count / LIMITED_GROUPS_NUM)+1

    @groups = @groups.offset((@page-1) * LIMITED_GROUPS_NUM).limit(LIMITED_GROUPS_NUM)

  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @appointments = Appointment.where("group_id = ?" ,params[:id])
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.user = current_user
    @group.attend_num =0
    respond_to do |format|
      if @group.save
        current_user.create_action( :like , target: @group)
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def star
    @user = User.find(current_user.id)
    if @user.like_group?(params[:id]) == false
       @user.like_group(params[:id])
       @favorite_exists = true
       respond_to do |format|
          format.html { redirect_to groups_url,   notice: 'group was successfully liked.' }
          format.json { head :no_content }
       end
    else
       @user.unlike_group(params[:id])
    #  @group.likes_count.save(touch: false)
       @favorite_exists = false
       respond_to do |format|
          format.html { redirect_to groups_url,  notice: 'group was successfully unliked.' }
          format.json { head :no_content }
       end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description,:attend_num)
    end
end
