class ArticlesMailer < ApplicationMailer

  def first_article(article_id)
    @article = Article.find(article_id)
    @user = @article.user
    
    mail(to: @user.email, subject: "You published your first article!")
  end
end
