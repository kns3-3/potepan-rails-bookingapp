class ReservationsController < ApplicationController
  before_action :authenticate_user! #ログインしていないと予約できない

  def confirm
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @room = Room.find(params[:reservation][:room_id])

    #バリデーションエラーがあれば詳細画面を読み込む
    if @reservation.invalid?
      render "rooms/show"
    else
      #バリデーションが問題なければ計算処理をする
      #終了日-開始日で宿泊日数を計算する
      @stay_days = (@reservation.end_date - @reservation.start_date).to_i
      #施設料金×宿泊日数×人数で合計金額を計算する
      @total_price = @room.price * @stay_days * @reservation.person_count
    end
  end

    def create
      @reservation = Reservation.new(reservation_params)
      @reservation.user_id = current_user.id

      if @reservation.save
        redirect_to reservations_path, notice: "予約が完了しました！"
      else
        #保存失敗時、画面表示に必要なデータを揃え直す
        #予約情報のルームIDからRoomテーブル内の情報を変数に入れる
        @room =Room.find(@reservation.room_id)
        @stay_days = (@reservation.end_date - @reservation.start_date).to_i
        @total_price = @room.price * @stay_days * @reservation.person_count
        render :confirm
      end
    end

    def index
      #ログインしているユーザーの予約を予約日時の降順に並べて取得する
      @reservations = current_user.reservations.order(created_at: :desc)
    end

  private

  #ストロングパラメータ
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :person_count, :room_id, :user_id)
  end
end
