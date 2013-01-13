#coding: utf-8
module ChatsHelper
  require 'date'

  def html_maker(data)
    html = '<div id="chat_list">'
    data.each do |m|
      case m[:type]
        when DATE, INVITATION, LEAVE
          html << info_maker(m[:message])
        when MESSAGE
          html << "<div class = 'messageContainer'><div class = '#{m[:isMine] ? 'messageDiv isMine' : 'messageDiv isNotMine'}'>"
          if m[:isMine]
            html << "<div class = 'message'> #{m[:message]} </div><div class = 'time'>#{m[:time]}</div>"
          else
            html << "
            <div class = 'profilePicContainer'>
              <div class = 'profilePic'>
              </div>
            </div>
            <div class = 'rightPart'>
              <div class = 'name'> #{m[:name]} </div>
              <div class = 'message'> #{m[:message]} </div>
              <div class = 'time'> #{m[:time]} </div>
            </div>
            "
          end
          html << "</div></div>"
      end
    end
    html << "</div>"
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
