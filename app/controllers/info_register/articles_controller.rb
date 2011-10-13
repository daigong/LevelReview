#encoding=utf-8
class InfoRegister::ArticlesController < InfoRegister::BaseController
  #显示全部论文
  #提供新增论文
  def index
    @info_register_articles = InfoRegister::Article.where({:owner_id.eq=>login_user.id}).
        order(:publication_type);
    @new_article = InfoRegister::Article.new
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  #增加论文,同时增加论文在活动中的审核状态
  def create
    @info_register_article = InfoRegister::Article.new(params[:info_register_article])
    @info_register_article.owner = login_user
    respond_to do |format|
      if @info_register_article.save
        #创建论文审核记录关系
        relation = InfoRegister::ArticleActivityRelation.new
        relation.activity=curr_activity
        relation.article=@info_register_article
        relation.result="create"
        relation.save
        format.html { redirect_to info_register_articles_url(curr_activity), notice: '增加成功！' }
      else
        format.html { redirect_to info_register_articles_url(curr_activity) }
      end
    end
  end

  def update
    @info_register_article = InfoRegister::Article.find(params[:id])

    respond_to do |format|
      if @info_register_article.update_attributes(params[:info_register_article])
        format.json { head :ok }
      else
        format.json { render json: @info_register_article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @info_register_article = InfoRegister::Article.find(params[:id])
    @info_register_article.destroy

    respond_to do |format|
      format.html { redirect_to info_register_articles_url(curr_activity) }
    end
  end
end
