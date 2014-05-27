{View} = require 'atom'

module.exports =
class DataAtomView extends View
   @content: ->
      @div class: 'panel-heading padded heading header-view results-header', =>
         @span 'Data Results on', class: 'heading-title', outlet: 'title'
         @span class: '', =>
            @select outlet: 'connectionList', class: ''
            @button 'New Connection...', class: 'btn btn-default', click: 'onNewConnection', outlet: 'connectionBtn'
            @button 'Disconnect', class: 'btn btn-default', click: 'onDisconnect', outlet: 'disconnectBtn'
         @span
            class: 'heading-close icon-remove-close pull-right'
            outlet: 'closeButton'
            click: 'close'

   close: ->
      atom.workspaceView.trigger 'data-atom:toggle-results-view'

   initialize: ->
      @connectionList.disable()
      @disconnectBtn.disable()

   addConnection: (connectionName) ->
      @connectionList.append('<option value="' + connectionName + '">' + connectionName + '</option>')
      @connectionList.children("option[value='" + connectionName + "']").prop('selected', true)
      @connectionList.enable()
      @disconnectBtn.enable()

   onNewConnection: ->
      @trigger('data-atom:new-connection')

   onDisconnect: ->
      # remove the connection from our list
      #@connectionList.children("option[value='" + connectionName + "']").prop('selected', true)
      @connectionList.children(":selected").remove()
      unless @connectionList.children().length
         @disconnectBtn.disable()
         @connectionList.disable()

      @trigger('data-atom:disconnect')
