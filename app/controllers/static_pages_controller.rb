# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index; 
    @categories = Category.where("approved = ?", true).all.shuffle[0...10]

    @articles = Article.where(approved: true).and(Article.where.not('status =?', 'members only')).all.shuffle[0...10]
  end
end



