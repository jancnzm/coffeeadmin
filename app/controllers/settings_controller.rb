class SettingsController < ApplicationController
  def index
@setting = Setting.first
    if !@setting
      Setting.create(cupratio:15)
    end
  end

  def init_busine_pinyin
    busines = Busine.all
    busines.each do |f|
      pinyin = HanziToPinyin.hanzi_to_pinyin(f.name)
      f.pinyin = safestring(pinyin)
      #debugger
      f.save
    end
  end

  def changecupratio
    setting = Setting.first
    setting.cupratio=params[:cupratio]
    setting.save
    render json: '{"cupratio":"'+setting.cupratio.to_s+'"}'
  end

  private
  def safestring(str)
    mystr =""
    str.each_byte  do |byte|
      if (byte > 47 && byte < 58) || (byte > 96 && byte < 123)
        mystr+=byte.chr
      end
    end
    return mystr
  end

end
