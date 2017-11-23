class Apiv2Controller < ApplicationController
  def getseller
    busines = Busine.all.paginate(:page => params[:page], :per_page => 10).order("id desc")
    render json:params[:callback]+'('+busines.to_json+')',content_type: "application/javascript"
  end

  def getsellersearch
    keyword=""
    if params[:keyword]
    keyword = params[:keyword].strip.downcase
    end
    if keyword && keyword.length > 0
      busines = Busine.where('name like ? or pinyin like ?','%'+keyword+'%','%'+keyword+'%').paginate(:page => params[:searchpage], :per_page => 10).order("id desc")
      render json:params[:callback]+'('+busines.to_json+')',content_type: "application/javascript"
    else
      render json:params[:callback]+'([])',content_type: "application/javascript"
    end
  end
  def getselectseller
    busines = Busine.where('name like ?','%' + params[:name] + '%')
    render json:params[:callback]+'('+busines.to_json+')',content_type: "application/javascript"
  end

end
