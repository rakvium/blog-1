# To deliver this notification:
#
# DislikeNotification.with(post: @post).deliver_later(current_user)
# DislikeNotification.with(post: @post).deliver(current_user)

class DislikeNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    @dislike = Dislike.find(params[:dislike][:id])
    @article = Article.find(params[:dislike][:dislikeable_id])
    @user = User.find(@article.user_id)
    "#{@user.user_name} #{t("disliked")} #{@article.title.truncate_words(10)}"
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
