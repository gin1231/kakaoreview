module ChatsHelper
  def html_maker(data)
    html = ""
    html << '<ul id="chat_list">'
    data.each do |m|
      case m[:type]
      when 0
        unless m[:date].nil?
          html << '<li class="date">'+m[:date]+'</li>'
        end
        html << '<li><span class="name">'+m[:name]+'</span>'+'<span class="message">'+m[:message]+'</span><span class="time">'+m[:time]+'</span></li>'
      when 1
        html << '<li class="invitation">'+m[:message]+'<span class="time">'+m[:time]+'</span></li>'
      when 2
      end
    end
    html << "</ul>"
    html
  end
end
