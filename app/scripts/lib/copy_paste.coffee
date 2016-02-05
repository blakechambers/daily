# http://stackoverflow.com/a/6804718

handlepaste = (elem, e) ->
  savedcontent = elem.innerHTML
  if e and e.clipboardData and e.clipboardData.getData
    # Webkit - get data from clipboard, put into editdiv, cleanup, then cancel event
    if /text\/html/.test(e.clipboardData.types)
      elem.innerHTML = e.clipboardData.getData('text/html')
    else if /text\/plain/.test(e.clipboardData.types)
      elem.innerHTML = e.clipboardData.getData('text/plain')
    else
      elem.innerHTML = ''
    waitforpastedata elem, savedcontent
    if e.preventDefault
      e.stopPropagation()
      e.preventDefault()
    false
  else
    # Everything else - empty editdiv and allow browser to paste content into it, then cleanup
    elem.innerHTML = ''
    waitforpastedata elem, savedcontent
    true

waitforpastedata = (elem, savedcontent) ->
  if elem.childNodes and elem.childNodes.length > 0
    processpaste elem, savedcontent
  else
    that =
      e: elem
      s: savedcontent

    that.callself = ->
      waitforpastedata that.e, that.s
      return

    setTimeout that.callself, 20
  return

processpaste = (elem, savedcontent) ->
  pasteddata = elem.innerHTML
  #^^Alternatively loop through dom (elem.childNodes or elem.getElementsByTagName) here
  elem.innerHTML = savedcontent
  # Do whatever with gathered data;
  alert pasteddata
  return

module.exports = handlepaste
