class EducationsController < ApplicationController
  before_filter :check_login?
  before_filter :find_edu,:only=>[:edit,:update,:destroy]
  # GET /educations/new
  # GET /educations/new.xml
  def new
    @education = Education.new
    respond_to do |format|
      format.js {}
      format.html # new.html.erb
      format.xml  { render :xml => @education }
    end
  end

  # GET /educations/1/edit
  def edit
    respond_to do |format|
      format.js {}
      format.html # new.html.erb
      format.xml  { render :xml => @education }
    end
  end

  # POST /educations
  # POST /educations.xml
  def create
    @education= current_user.educations.build(params[:education])
    respond_to do |format|
      if @education.save
        format.js {}
        format.html {
          flash[:success] = '教育创建成功.'
          redirect_to new_user_education_path(params[:user_id],
            params[:resume_id])
        }
        format.xml  { render :xml => @education, :status => :created, :location => @education }
      else
        flash.now[:error] = @education.errors.full_messages.to_s
        format.js {}
        format.html { render :action => "new" }
        format.xml  { render :xml => @education.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /educations/1
  # PUT /educations/1.xml
  def update
    respond_to do |format|
      if @education.update_attributes(params[:education])
        format.js {}
        format.html {
          flash[:notice] = '编辑成功.'
          redirect_to(user_education_path(current_user, @education)) }
        format.xml  { head :ok }
      else
        flash.now[:error] = @education.errors.full_messages.to_s
        format.js {  }
        format.html { render :action => "edit" }
        format.xml  { render :xml => @education.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.xml
  def destroy
    @education.destroy
    respond_to do |format|
      format.js {}
      format.html { redirect_to(user_educations_path(params[:user_id])) }
      format.xml  { head :ok }
    end
  end

  #查询 学校名称
  def auto_complete_for_education_school_name
    @items =  School.find(:all,
      :conditions =>["lower(name) like ?    ","%#{params[:education][:school_name].downcase}%"])
    render :inline => "<%= auto_complete_result @items, 'school_name', '#{params[:education][:school_name]}' %>"
  end

  protected

  def find_edu
    @education = current_user.educations.find(params[:id])
  end
end
