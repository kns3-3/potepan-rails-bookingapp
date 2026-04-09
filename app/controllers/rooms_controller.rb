class RoomsController < ApplicationController
  # ログインしないとnewとcreateは操作できない
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @rooms = Room.all
  end

  def new
    @room =Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to room_path(@room), notice: "施設を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room =Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "施設情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました", status: :see_other
  end

  # あいまい検索のアクション
  def search
    @rooms =Room.all

    # エリアが選択されたら、そのエリアで絞り込む
    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    # 施設名か施設詳細のどちらかにワードが含まれていればヒットする
    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    @count = @rooms.count
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
