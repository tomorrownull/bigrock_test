class RecommendsController < ApplicationController
  before_filter :check_login?
  # GET /recommends/new
  # GET /recommends/new.xml
  def new
    @recommend = Recommend.new
    if params[:recommendable_type] && params[:recommendable_id]
      recommendable =  params[:recommendable_type].camelize.constantize.find( params[:recommendable_id])
      @recommend.recommendable = recommendable
      #      @recommend.recommendable_type = params[:recommendable_type]
      #      @recommend.recommendable_id = params[:recommendable_id]
    end
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.xml  { render :xml => @recommend }
    end
  end
  def index
    @page_title= "推荐列表"
    @recommends = Recommend.
      paginate_all_by_recommendable_id_and_recommendable_type(params[:recommendable_id],params[:recommendable_type],:page=>params[:page])
  end
 

  # POST /recommends
  # POST /recommends.xml
  def create
    @recommend = Recommend.new(params[:recommend])
    respond_to do |format|
      if  current_user.recommends << @recommend
        flash.now[:success] = '推荐成功！'
        format.js  {}
        format.html { redirect_to(@recommend) }
        format.xml  { render :xml => @recommend, :status => :created, :location => @recommend }
      else
        format.js  {}
        format.html { render :action => "new" }
        format.xml  { render :xml => @recommend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recommends/1
  # DELETE /recommends/1.xml
  def destroy
    @recommend = Recommend.find(params[:id])
    @recommendable = @recommend.recommendable
    current_user.recommends.destroy(@recommend)
    respond_to do |format|
      flash.now[:success] = '推荐已经取消！'
      format.html { redirect_to(recommends_url) }
      format.js { }
      format.xml  { head :ok }
    end
  end
end
