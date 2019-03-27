class NotificationsController < ApplicationController
  before_action :set_notification, except: [:index, :mark_as_read]

  def index
    @notifications = notifications.includes(:actor).order('id desc').page(params[:page])
    @notification_groups = @notifications.group_by { |note| note.created_at.to_date }
  end

  def show
    Notification.read!(@notification.id)
    redirect_to article_path(@notification.second_target)
  end

  def destroy
    @notification.destroy
    redirect_to notifications_path
  end

  def mark_as_read

    @notifications = notifications
    unread_ids = @notifications.reject(&:read?).select(&:id)
    Notification.read!(unread_ids)
    redirect_to notifications_path
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notifications
    raise 'You need reqiure user login for /notifications page.' unless current_user
    Notification.where(user_id: current_user.id)
  end
end
