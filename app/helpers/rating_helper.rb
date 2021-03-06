module RatingHelper
  #生成 rank 组件
  def rating_field(object,method,options={})
    options = {:id=>"#{object}_#{method}_Rank"}.merge(options)
    
    function =  "  var rank = new StarRank();"
    function << "rank.imgEmpty_class='#{options[:empty_class]}';"     if options[:empty_class]
    function << "rank.imgOver_class='#{options[:over_class]}';"     if options[:over_class]
    function << "rank.imgFull_class='#{options[:full_class]}';"     if options[:full_class]
    
    function << "rank.disabled=#{options[:disabled]};"     if options[:disabled]
    function << "rank.create('#{object}_#{method}_Rank', '#{object}_#{method}');"
 
    function << "rank.setRankValue($('#{object}_#{method}').value);" 
    function << "rank.rankClick = function(sender, id, value) {"
    function << "$('#{object}_#{method}').value = value;"
    #    function << "sender.disabled = true;"
    #    function << "var _self = this;"
    function << " }"
 

    if options[:value]
      content_tag(:div, hidden_field_tag("#{object}[#{method}]",options[:value] ? options[:value] : 0,
          :class=>"int-range-1-5 validation-failed  required",:title=>"评价一下吧")+ (options[:extension_html] || "") ,options)+
        javascript_tag(function)
    else
      content_tag(:div, hidden_field(object,method,:class=>"int-range-1-5 validation-failed required",:title=>"评价一下吧")+ (options[:extension_html] || ""),options)+
        javascript_tag(function)
    end
  end
end
