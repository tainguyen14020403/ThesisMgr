class Admin::SpheresController < ApplicationController
  before_action :user_signin
  skip_before_action :verify_authenticity_token
  before_action :admin, only: [:edit, :update, :destroy, :new]
  before_action :find_sphere, only: [:show, :edit, :update, :destroy]
  def index
    @spheres = Sphere.all
    @list_tree_spheres = show_tree(@spheres,0,0)
  end

  def show
  end

  def new
    @list_spheres = Sphere.all
    @list_tree_spheres = show_tree(@list_spheres,0,0)
    @sphere = Sphere.new
  end

  def create
    @sphere = Sphere.new(name: params[:name], description: params[:description], parent_id: params[:parent_id])
    if @sphere.save
      flash[:success] = "Thêm lĩnh vực thành công"
      redirect_to admin_spheres_path
    else
      flash[:danger] = "Thêm lĩnh vực thất bại"
      render :new
    end
    # render text: params
  end

  def edit
    @spheres = Sphere.all
    @list_tree_spheres = show_tree(@spheres,0,0)
  end

  def update
    if @sphere.update_attributes(name: params[:name], description: params[:description], parent_id: params[:parent_id])
      flash[:success] = "Cập nhật lĩnh vực thành công"
      redirect_to admin_spheres_path
    else
      flash[:danger] = "Cập nhật lĩnh vực thất bại"
      render :edit
    end
    #render text: params
  end

  def destroy
    if @sphere.destroy
      flash[:success] = "Xóa lĩnh vực thành công"
      redirect_to admin_spheres_path
    else
      flash[:danger] = "Xóa lĩnh vực thất bại"
      redirect_to admin_spheres_path
    end
  end

  private
  def find_sphere
    @sphere = Sphere.find_by(id: params[:id])
  end
end
