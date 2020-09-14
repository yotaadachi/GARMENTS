class NotificationsController < ApplicationController

  def index
    #current_userの投稿に関する通知
    @notifications = current_user.passive_notifications
    #@notificationsの中でまだ確認していない通知
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end

end
