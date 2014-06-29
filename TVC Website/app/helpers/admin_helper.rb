module AdminHelper

  def show_sex(sex)
    sex ? '男' : "女"
  end

  def show_yes(yes)
    yes ? '是' : "否"
  end

  def show_status(status)
    if status.to_i == 3
      "已经确定"
    elsif status.to_i == 2
      "已经删除"
    else
      "还未确定"
    end
  end

  def show_category(category)
    if category.to_i == 3
      "活动介绍"
    elsif category.to_i == 2
      "视频资料"
    else
      "小组介绍"
    end
  end

end
