share_mode = false
edit_mode = false

#show
$(document).ready ->
  changeMessageForm()
  changeMessageField()
  $("#message_message_type").change ->
    changeMessageForm()
    changeMessageField()
  $("#message_name, #message_name_by").on 'keypress keyup keydown', ->
    changeMessageField()
  return

changeMessageForm = () ->
  message_type = parseInt($("#message_message_type option:selected").val())
  $(".messageField").hide()
  $(".messageFieldType" + message_type).show()
  return

changeMessageField = () ->
  message_type = parseInt($("#message_message_type option:selected").val())
  if message_type == 0
    msg = "날짜!"
    $("#message_message").attr("disabled", true)
  else if message_type == 3
    msg = $("#message_name_by").val() + "님이 " + $("#message_name").val() + "님을 초대했습니다."
    $("#message_message").attr("disabled", true)
  else if message_type == 4
    msg = $("#message_name").val() + "님이 퇴장했습니다."
    $("#message_message").attr("disabled", true)
  else
    $("#message_message").attr("disabled", false)

  $("#message_message").val(msg)
  return




window.toTop = () ->
  $("html").animate({scrollTop: 0}, "slow")
  return


window.toBottom = () ->
  $("html").animate({scrollTop: $(document).height()}, "slow") 
  return

#edit
window.toggleTitle = () ->
  $(".chatTitle").toggle()

window.toggleEdit = () ->
  $(".editDiv").toggle()

#share
start_div = null
end_div = null

window.toggleShare = (id) ->
  message_divs = $(".infoContainer, .messageContainer")
  if share_mode == false
    share_mode = true
    chat_id = id
    toggleShareStart(id)
  else
    share_mode = false
    message_divs.off()
    message_divs.css('background-color', '')


toggleShareStart = (id) ->
  alert('시작지점을 선택해주세요')
  start_div = null
  end_div = null
  message_divs = $(".infoContainer, .messageContainer")
  message_divs.on "mouseenter", (event) ->
    $(this).css('background-color', '#ecc')
    $(this).click ->
      start_div = $(this)
      start_div.addClass('messageSelected')
      toggleShareEnd(id)
  message_divs.on "mouseleave", (event) ->
    $(this).css('background-color', '')
  return

toggleShareEnd = (id) ->
  alert('끝지점을 선택해주세요')
  message_divs = $(".infoContainer, .messageContainer")
  message_divs.off()
  message_divs.on "mouseenter", (event) ->
    $(this).css('background-color', '#ecc')
    $(this).click ->
      end_div = $(this)
      end_div.addClass('messageSelected')
      message_divs.css('background-color', '')
      newPart(id)
  message_divs.on "mouseleave", (event) ->
    $(this).css('background-color', '')
  return

newPart = (id) ->
  message_divs = $(".infoContainer, .messageContainer")
  message_divs.off()
  if (start_div == null) or (end_div == null)
    alert('잘못된 접근입니다')
  else
    start_div.removeClass('messageSelected')
    end_div.removeClass('messageSelected')

    start = start_div.attr("id").split("_")[1]
    end = end_div.attr("id").split("_")[1]

    if start > end
      alert('시작지점이 더 앞이어야 합니다')
      toggleShareEnd(id)
    else
      $.colorbox({href: "/chats/" + id + "/parts/new?start=" + start + "&end=" + end})
      toggleShare()
  return
