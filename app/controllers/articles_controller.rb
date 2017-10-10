class ArticlesController < ApplicationController

  def index
    logged_in
    if user_current.role != 'admin'
      @draft = Article.friendly.where(:user_id => user_current.id)
    else
      @draft = Article.friendly.all
    end
  end

  def show
    @article = Article.friendly.where(:published => true).find(params[:id])
    if params[:slug] != @article.slug
      redirect_to article_path(@article.slug, @article.id)
    end
  end

  def new
    logged_in
    @draft = Article.new
  end

  def create
    @draft = Article.new(article_params)

    if @draft.save
      @draft.update_attributes(:user_id => user_current.id)
      flash[:success] = "Le brouillon a bien été créer"
      redirect_to articles_path
    else
      flash[:error] = "Corriger vos erreurs"
      render 'new'
    end
  end

  def edit
    @draft = Article.find(params[:id])

    unless user_current.id != @draft.user_id or user_current.role == 'admin'
      flash[:error] = "Cet article ne vous appartient pas"
      redirect_to '/'
    end
  end

  def update
    @draft = Article.friendly.find(params[:id])

    if @draft.update(article_params)
      @draft.update_attributes(:user_id => user_current.id)
      flash[:success] = "L'article a bien été mis à jour"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def delete
    @article = Article.find(params[:id])
    if user_current.id != @article.user_id
      flash[:success] = "Ce article ne vous appartient pas"
      redirect_to articles_path
    end
    Article.destroy(params[:id])
    flash[:success] = "L'article a bien été supprimé"
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :slug, :content, :user_id, :published)
    end
end
