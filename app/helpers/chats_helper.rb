#coding: utf-8
module ChatsHelper
  require 'date'

  def html_maker(data)
    html = ''
    data.each do |m|
      case m[:type]
        when DATE, INVITATION, LEAVE
          html << info_maker(m[:message])
        when MESSAGE
          if m[:isMine]
            html << "<div class = 'messageContainer'><div class = 'messageDiv isMine'>"
            html << message_maker(m) << "<div class = 'time'>#{m[:time]}</div>"
          else
            html << "<div class = 'messageContainer'><div class = 'messageDiv isNotMine'>"
            html << "<div class = 'profilePicContainer'><div class = 'profilePic'></div></div>"
            html << "<div class = 'rightPart'> <div class = 'name'> #{m[:name]} </div>"
            html << message_maker(m) << "<div class = 'time'> #{m[:time]} </div></div>"
          end
          html << "</div></div>"
      end
    end
    html
  end

  def message_maker(m)
    if m[:content] == TEXT
      "<div class = 'message textMessage'> #{m[:message]} </div>"
    elsif m[:content] == IMAGE
      "<div class = 'message imageMessage'> #{m[:message]} </div>"
    elsif m[:content] == AUDIO
      "<div class = 'message audioMessage'><a href = '#{m[:message]}'><img src = '/assets/voiceplay.png'></a></div>"
    elsif m[:content] == VIDEO
      "<div class = 'message videoMessage'><a href = '#{m[:message]}'><img src = '/assets/video.png'></a></div>"
    else
      "<div class = 'message unknownMessage'> #{m[:message]} </div>"
    end
  end

  def info_maker(str)
    "
      <div class = 'infoContainer'>
        <div class = 'infoInnerContainer'>
          <div class = 'infoLeftContainer'>
            <div class = 'infoLeftCol'></div>
            <div class = 'info'> #{str} </div>
          </div>
        </div>
        <div class = 'infoRightCol'></div>
      </div>
    "
  end


end
