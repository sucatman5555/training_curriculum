class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    # 2020/12/24 edit S.Shimada
    # Issue2【命名規則を遵守できていないメソッドを修正する】
    # getWeek
    get_week
    # 2020/12/24 edit end
    @plan = Plan.new
  end

  # 予定の保存
  def create
    # binding.pry # Issue4確認用
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    # 2020/12/24 edit S.Shimada
    # Issue4【予定を入力し保存ボタンを押しても、保存されないバグを修正する】
    # params.require(:calendars).permit(:date, :plan)
    params.require(:plan).permit(:date, :plan)
    # 2020/12/24 edit end
  end

  # 2020/12/24 edit S.Shimada
  # Issue2【命名規則を遵守できていないメソッドを修正する】
  # def getWeek
  def get_week
  # 2020/12/24 edit end
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      # 2020/12/24 edit S.Shimada
      # Issue1【古い記述であるハッシュロケットをシンボル型へ書き換える】
      # days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :plans => today_plans}
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_plans}
      # 2020/12/24 edit end
      @week_days.push(days)
    end

  end
end
