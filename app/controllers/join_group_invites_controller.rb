class JoinGroupInvitesController < ApplicationController
  def index
    @page_title ="加入小组邀请信息列表"
    @invites =  current_user.join_group_invites.paginate :page => params[:page]
  end

  def accept
    @apply = current_user.join_group_invites.find(params[:id])
    if @apply.accept(current_user)
      flash[:success] = "加入成功！"
    else
      flash[:success] = "加人失败！"
    end

    redirect_to :action=>"index"  , :page => params[:page]
  end

  def destroy
    @apply = current_user.join_group_invites.find(params[:id])
    @apply.destroy
    flash[:success] = "已经忽略！"
    redirect_to :action=>"index"  , :page => params[:page]
  end

end
