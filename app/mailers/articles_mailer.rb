class ArticlesMailer < ApplicationMailer

  def first_article
    @user = params[:user]
    @url  = params[:article]
    mail(to: @user.email, subject: "You published your first article!")
  end
end
