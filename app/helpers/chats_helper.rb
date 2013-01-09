#coding: utf-8
module ChatsHelper
  require 'date'

  def html_maker(data)
    html = ""
    html << '<div id="chat_list">'
    data.each do |m|

      className = "messageDiv isNotMine"

      if m[:name] == "회원님"
        className = "messageDiv isMine"
      end
        
      case m[:type]
      
      
      when MESSAGE
        unless m[:date].nil?
          html << "
                    <div class = 'dateContainer'>
                      <div class = 'dateInnerContainer'>
                        <div class = 'dateLeftContainer'>
                          <div class = 'dateLeftCol'></div>
                          <div class = 'date'> #{date_parser(m[:date])} </div>
                        </div>
                      </div>
                      <div class = 'dateRightCol'></div>
                    </div>
                  "
        end
        html << "<div class = 'messageContainer'><div class = '#{className}'>"
        if m[:name] == "회원님"
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
      when INVITATION
        html << "<li class = 'invitation'> #{m[:message]} <span class = 'time'>#{m[:time]}</span></li>"
      when MULTILINEMESSAGE
        html << "<li class = 'mlMessage'>#{m[:message]}</li>"
      end

    end
    html << "</div>"
    html
  end

  def date_parser(date)
    return date#temp for test
    newDate = Date.parse(date)
    day = case newDate.wday
      when 0 then "일요일"
      when 1 then "월요일"
      when 2 then "화요일"
      when 3 then "수요일"
      when 4 then "목요일"
      when 5 then "금요일"
      when 6 then "토요일"
    end

    newDate.year.to_s + "년 " + newDate.month.to_s + "월 " + newDate.day.to_s + "일 " + day
  end

end
