class TagsController < ApplicationController
  #显示tag 有两种方式
  #一种 根据固定的id显示 某一company 或 group下面的tag
  #另一种   company 或 group类型的所有的tag
  def index
    
    @tag_type = params[:type] || "Company"
    if params[:group_id]
      @owner = Group.find(params[:group_id])
    elsif params[:company_id]
      @owner = Company.find(params[:company_id])
    end
    if @owner
      @tags = @owner.taggings.paginate :conditions=>["tags.name like ? ", '%'+params[:search].to_s+'%'],
        :joins=>:tag,:order=>"user_tags_count desc", :page => params[:page]
      @label=  @owner.name
    else
      @tags =@tag_type.camelize.constantize.all_tags( :conditions=>["tags.name like ? ", '%'+params[:search].to_s+'%']).paginate :page => params[:page]
      @label=   @tag_type.to_s.downcase.eql?("company") ? "公司" : "小组"
    end
  end
  
  def show
    @tag_type = params[:type] || "Company"
    @tag = Tag.find(params[:id])
    @objects = @tag.taggables.paginate :conditions=>["taggable_type=?",@tag_type],:page => params[:page]
    #    taggable_ids = @tag.taggings.all(:conditions=>["taggable_type=?",Company.to_s],:limit=>10,:order=>"user_tags_count desc").map(&:taggable_id)
    @similar_taggings = @tag_type.to_s.camelize.constantize.find_related_tags(@tag.name,:limit=>10) #Tagging.find(:all,:conditions=>["taggable_id in (?) and tag_id<>?",taggable_ids,@tag.id],:limit=>10,:order=>"user_tags_count desc")
  end
  

end