class ArticlesController < ApplicationController
  before_action :set_article, only:  [:show, :edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article created successfully."
    else
      render :new
    end
  end
  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, notice: "Article deleted successfully."
  end

  def index
    @articles = Article.all
  end

 private
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end