class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  LIMITED_projectS_NUM =10
  # GET /projects
  # GET /projects.json
  def index
    if !params[:category].blank?
      @projects = Project.where(["category_id = ? ", params[:category]])
    else
      @projects = Project.all      
    end

    if params[:page]
      @page= params[:page].to_i
    else 
      @page = 1
    end

=begin    
    @projects=[]
    (1...100).each do |index|
      project ={

        id: index,
        price: 10,
      }
      @projects << project
    end
=end


#    @projects = project.all
      @first_page =(@projects.count==0)? 0:1
    @last_page=(@projects.count / LIMITED_projectS_NUM)+1

    @projects = @projects.offset((@page-1) * LIMITED_projectS_NUM).limit(LIMITED_projectS_NUM)

  end

  # GET /projects/1
  # GET /projects/1.json
  def show


    @users = @project.like_by_users
    
    
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        current_user.create_action( :like , target: @project)
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def star
    @user = User.find(current_user.id)
  

    if @user.like_project?(params[:id]) == false
       @user.like_project(params[:id])
       @favorite_exists = true
       respond_to do |format|
          format.html { redirect_to projects_url,   notice: 'Project was successfully liked.' }
          format.json { head :no_content }
       end
    else
       @user.unlike_project(params[:id])
    #  @project.likes_count.save(touch: false)
       @favorite_exists = false
       respond_to do |format|
          format.html { redirect_to projects_url,  notice: 'Project was successfully unliked.' }
          format.json { head :no_content }
       end
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :id ,:category_id)
    end
end
